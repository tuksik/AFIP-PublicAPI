{$I jedi.inc}

unit MainForm;

interface

uses
  Afip.PublicAPI,
  Afip.PublicAPI.Types,
  Afip.PublicAPI.HttpClient,
  Afip.PublicAPI.Parsers,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Controls,
  ComCtrls,
  Classes;

type
  TMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MemoQueryDni: TMemo;
    btnQueryDni: TButton;
    edNroDni: TLabeledEdit;
    TabSheet3: TTabSheet;
    btnObtenerConstancia: TButton;
    SaveDialog1: TSaveDialog;
    edCuitConstancia: TLabeledEdit;
    TabSheet4: TTabSheet;
    btnGetParametros: TButton;
    cbParametros: TComboBox;
    lbTime: TLabel;
    pTop: TPanel;
    rgHttpLibrary: TRadioGroup;
    edNroCuit: TLabeledEdit;
    MemoRawJsonPersona: TMemo;
    btnQueryPersona: TButton;
    MemoQueryPersona: TMemo;
    memoParametros: TMemo;
    rgPersistencia: TRadioGroup;
    rgJsonLibrary: TRadioGroup;
    procedure btnQueryPersonaClick(Sender: TObject);
    procedure btnQueryDniClick(Sender: TObject);
    procedure btnObtenerConstanciaClick(Sender: TObject);
    procedure btnGetParametrosClick(Sender: TObject);
    procedure rgPersistenciaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    FPersister: IPersister_Afip;

    procedure DoGetParametros(const AText: string);

    function GetHttpClient: IHttpClient;
    function GetPersonParser: IAfip_PersonParser;
    function GetItemsParser: IAfip_ItemParser;

    function CreateAfipAPI: IApi_Afip;
  strict protected
    property Persister: IPersister_Afip read FPersister;
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses
  Afip.PublicAPI.Persistance,
  Afip.PublicAPI.SynapseHttpClient,
  Afip.PublicAPI.Parsers.lkJson,
  SysUtils,
  Generics.Collections;

function ParseArray(Input: TArray<Integer>): string;
var
  s: Integer;
begin
  for s in Input do
  begin
    if Result = EmptyStr then
      Result := IntToStr(s)
    else
      Result := Result + ', ' + IntToStr(s);
  end;
end;

function ParseArrayCategorias(Input: TArray<TIntegersPair>): string;
var
  LPair: TPair<Integer, Integer>;
  AString: string;
begin
  for LPair in Input do
  begin
    AString := Format('[%d, %d]', [LPair.Key, LPair.Value]);
    if Result = EmptyStr then
      Result := AString
    else
      Result := Result + ' - ' + AString;
  end;
end;

procedure TMain.rgPersistenciaClick(Sender: TObject);
begin
  case rgPersistencia.ItemIndex of
    1: FPersister := TMemoryAfipPersister.Create;
  else
    FPersister := NIL; // no usar persistencia
  end;
end;

function TMain.GetHttpClient: IHttpClient;
begin
  case rgHttpLibrary.ItemIndex of
    0: Result := TSynapseHttpClient.Create;
  else
    raise Exception.Create('Debe indicar una biblioteca HTTP');
  end;
end;

function TMain.GetItemsParser: IAfip_ItemParser;
begin
  case rgJsonLibrary.ItemIndex of
    0: Result := TlkJsonAfip_Parser.Create;
  else
    raise Exception.Create('No se pudo crear IAfip_ItemParser :: Debe indicar una biblioteca JSON');
  end;
end;

function TMain.GetPersonParser: IAfip_PersonParser;
begin
  case rgJsonLibrary.ItemIndex of
    0: Result := TlkJsonAfip_Parser.Create;
  else
    raise Exception.Create('No se pudo crear IAfip_PersonParser :: Debe indicar una biblioteca JSON');
  end;
end;

function TMain.CreateAfipAPI: IApi_Afip;
begin
  Result := TAfipQuery.Create(GetHttpClient, GetPersonParser, GetItemsParser, Persister);
end;

procedure TMain.btnQueryPersonaClick(Sender: TObject);
var
  Api: IApi_Afip;
  Persona: IPersona_Afip;
begin
  Api := CreateAfipAPI;
  Persona := Api.ConsultaPersona(edNroCuit.Text);
  MemoRawJsonPersona.Text := Persona.RawJson;
  MemoQueryPersona.Clear;
  MemoQueryPersona.Lines.Add('IdPersona = ' + IntToStr(Persona.IdPersona));
  MemoQueryPersona.Lines.Add('TipoPersona = ' + Persona.TipoPersona.ToString);
  MemoQueryPersona.Lines.Add('TipoClave = ' + Persona.TipoClave.ToString);
  MemoQueryPersona.Lines.Add('EstadoClave = ' + BoolToStr(Persona.EstadoClave, True));
  MemoQueryPersona.Lines.Add('Nombre = ' + Persona.Nombre);
  MemoQueryPersona.Lines.Add('TipoDocumento = ' + Persona.TipoDocumento);
  MemoQueryPersona.Lines.Add('NumeroDocumento = ' + Persona.NroDocumento);
  MemoQueryPersona.Lines.Add('IdDependencia = ' + IntToStr(Persona.IdDependencia));
  MemoQueryPersona.Lines.Add('MesCierre = ' + IntToStr(Persona.MesCierre));
  MemoQueryPersona.Lines.Add('FechaInscripcion = ' + DateToStr(Persona.FechaInscripcion));
  MemoQueryPersona.Lines.Add('FechaContratoSocial = ' + DateToStr(Persona.FechaContratoSocial));
  MemoQueryPersona.Lines.Add('FechaFallecimiento = ' + DateToStr(Persona.FechaFallecimiento));
  MemoQueryPersona.Lines.Add(Format('Impuestos = [%s]', [ParseArray(Persona.Impuestos)]));
  MemoQueryPersona.Lines.Add(Format('Caracterizaciones = [%s]', [ParseArray(Persona.Caracterizaciones)]));
  MemoQueryPersona.Lines.Add(Format('Actividades = [%s]', [ParseArray(Persona.Actividades)]));
  MemoQueryPersona.Lines.Add(Format('CategoriasMonotributo = [%s]', [ParseArrayCategorias(Persona.CategoriasMonotributo)]));
  MemoQueryPersona.Lines.Add('DomicilioFiscal = ' + Persona.DomicilioFiscal.ToString);
end;

procedure TMain.DoGetParametros(const AText: string);
var
  I: Integer;
  Api: IApi_Afip;
  Data: TArray<TItem_Afip>;
  Data_Dependencies: TArray<TDependencia_Afip>;
begin
  Api := CreateAfipAPI;
  if CompareText(AText, 'actividades') = 0 then
    Data := Api.GetActividades
  else if CompareText(AText, 'conceptos') = 0 then
    Data := Api.GetConceptos
  else if CompareText(AText, 'Impuestos') = 0 then
    Data := Api.GetImpuestos
  else if CompareText(AText, 'Caracterizaciones') = 0 then
    Data := Api.GetCaracterizaciones
  else if CompareText(AText, 'CategoriasMonotributo') = 0 then
    Data := Api.GetCategoriasMonotributo
  else if CompareText(AText, 'CategoriasAutonomo') = 0 then
    Data := Api.GetCategoriasAutonomo
  else if CompareText(AText, 'Provincias') = 0 then
    Data := Api.GetProvincias
  else if CompareText(AText, 'GetDependecias') = 0 then
  begin
    Data_Dependencies := Api.GetDependecias;
    memoParametros.Lines.BeginUpdate;
    try
      for I := 0 to High(Data) do
        memoParametros.Lines.Add(Format('Id %d, Descripcion %s', [Data_Dependencies[I].Id,
                                                                  Data_Dependencies[I].Descripcion]));
    finally
      memoParametros.Lines.EndUpdate;
    end;
    Exit;
  end;

  memoParametros.Lines.BeginUpdate;
  try
    for I := 0 to High(Data) do
      memoParametros.Lines.Add(Format('Id = %d ------ Descripcion = %s', [Data[I].Id, Data[I].Descripcion]));
  finally
    memoParametros.Lines.EndUpdate;
  end;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TMain.btnGetParametrosClick(Sender: TObject);
begin
  btnGetParametros.Enabled := False;
  try
    memoParametros.Clear;
    DoGetParametros(cbParametros.Text);
  finally
    btnGetParametros.Enabled := True;
  end;
end;

procedure TMain.btnObtenerConstanciaClick(Sender: TObject);
var
  Api: IApi_Afip;
  AStream: TStream;
  AFileStream: TFileStream;
begin
  Api := CreateAfipAPI;
  AStream := Api.ObtenerConstancia(edCuitConstancia.Text);
  try
    AStream.Position := 0;
    if not SaveDialog1.Execute then
      Exit;

    AFileStream := TFileStream.Create(SaveDialog1.FileName, fmCreate or fmOpenReadWrite);
    try
      AFileStream.CopyFrom(AStream, AStream.Size);
    finally
      AFileStream.Free;
      ShowMessage('Descargado');
    end;
  finally
    AStream.Free;
  end;
end;

procedure TMain.btnQueryDniClick(Sender: TObject);
var
  Api: IApi_Afip;
  Items: TArray<string>;
  Nro: string;
begin
  Api := CreateAfipAPI;
  Items := Api.ConsultaNroDocumento(edNroDni.Text);
  MemoQueryDni.Clear;
  for Nro in Items do
    MemoQueryDni.Lines.Add(Nro);
end;

end.
