object Main: TMain
  Left = 267
  Height = 554
  Top = 113
  Width = 759
  Caption = 'Test API Publica AFIP'
  ClientHeight = 554
  ClientWidth = 759
  Color = clBtnFace
  Font.CharSet = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  OnCreate = FormCreate
  Position = poScreenCenter
  LCLVersion = '1.6.0.4'
  object PageControl1: TPageControl
    Left = 0
    Height = 478
    Top = 76
    Width = 759
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Consulta por numero de cuit'
      ClientHeight = 448
      ClientWidth = 751
      object MemoQueryPersona: TMemo
        Left = 0
        Height = 244
        Top = 83
        Width = 751
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object btnQueryPersona: TButton
        Left = 328
        Height = 25
        Top = 15
        Width = 75
        Caption = 'Consultar'
        OnClick = btnQueryPersonaClick
        TabOrder = 2
      end
      object MemoRawJsonPersona: TMemo
        Left = 0
        Height = 121
        Top = 327
        Width = 751
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object edNroCuit: TLabeledEdit
        Left = 14
        Height = 25
        Top = 19
        Width = 292
        EditLabel.AnchorSideLeft.Control = edNroCuit
        EditLabel.AnchorSideRight.Control = edNroCuit
        EditLabel.AnchorSideRight.Side = asrBottom
        EditLabel.AnchorSideBottom.Control = edNroCuit
        EditLabel.Left = 14
        EditLabel.Height = 17
        EditLabel.Top = -1
        EditLabel.Width = 292
        EditLabel.Caption = 'Nro Cuit'
        EditLabel.ParentColor = False
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Consulta por numero de documento'
      ClientHeight = 0
      ClientWidth = 0
      ImageIndex = 1
      object MemoQueryDni: TMemo
        Left = 3
        Height = 347
        Top = 90
        Width = 745
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnQueryDni: TButton
        Left = 330
        Height = 25
        Top = 33
        Width = 75
        Caption = 'Consultar'
        OnClick = btnQueryDniClick
        TabOrder = 1
      end
      object edNroDni: TLabeledEdit
        Left = 7
        Height = 25
        Top = 33
        Width = 292
        EditLabel.AnchorSideLeft.Control = edNroDni
        EditLabel.AnchorSideRight.Control = edNroDni
        EditLabel.AnchorSideRight.Side = asrBottom
        EditLabel.AnchorSideBottom.Control = edNroDni
        EditLabel.Left = 0
        EditLabel.Height = 17
        EditLabel.Top = 0
        EditLabel.Width = 49
        EditLabel.Caption = 'Nro DNI'
        EditLabel.ParentColor = False
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Obtener PDF constancia'
      ClientHeight = 0
      ClientWidth = 0
      ImageIndex = 2
      object btnObtenerConstancia: TButton
        Left = 332
        Height = 25
        Top = 19
        Width = 75
        Caption = 'Descargar'
        OnClick = btnObtenerConstanciaClick
        TabOrder = 0
      end
      object edCuitConstancia: TLabeledEdit
        Left = 7
        Height = 25
        Top = 23
        Width = 292
        EditLabel.AnchorSideLeft.Control = edCuitConstancia
        EditLabel.AnchorSideRight.Control = edCuitConstancia
        EditLabel.AnchorSideRight.Side = asrBottom
        EditLabel.AnchorSideBottom.Control = edCuitConstancia
        EditLabel.Left = 0
        EditLabel.Height = 17
        EditLabel.Top = 0
        EditLabel.Width = 49
        EditLabel.Caption = 'Nro Cuit'
        EditLabel.ParentColor = False
        TabOrder = 1
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Parametros'
      ClientHeight = 0
      ClientWidth = 0
      ImageIndex = 3
      object lbTime: TLabel
        Left = 3
        Height = 17
        Top = 45
        Width = 745
        Align = alBottom
        Caption = 'Time:'
        ParentColor = False
      end
      object btnGetParametros: TButton
        Left = 188
        Height = 33
        Top = 10
        Width = 91
        Caption = 'Consultar'
        OnClick = btnGetParametrosClick
        TabOrder = 0
      end
      object cbParametros: TComboBox
        Left = 10
        Height = 25
        Top = 14
        Width = 145
        ItemHeight = 17
        ItemIndex = 0
        Items.Strings = (
          'Actividades'
          'Conceptos'
          'Provincias'
          'Caracterizaciones'
          'CategoriasMonotributo'
          'CategoriasAutonomo'
          'Impuestos'
          'Dependencias'
        )
        Style = csDropDownList
        TabOrder = 1
        Text = 'Actividades'
      end
      object memoParametros: TMemo
        Left = 3
        Height = 369
        Top = 68
        Width = 745
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
  end
  object pTop: TPanel
    Left = 0
    Height = 76
    Top = 0
    Width = 759
    Align = alTop
    BevelOuter = bvNone
    ClientHeight = 76
    ClientWidth = 759
    TabOrder = 1
    object rgHttpLibrary: TRadioGroup
      Left = 0
      Height = 76
      Top = 0
      Width = 236
      Align = alLeft
      AutoFill = True
      Caption = 'Biblioteca HTTP'
      ChildSizing.LeftRightSpacing = 6
      ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
      ChildSizing.EnlargeVertical = crsHomogenousChildResize
      ChildSizing.ShrinkHorizontal = crsScaleChilds
      ChildSizing.ShrinkVertical = crsScaleChilds
      ChildSizing.Layout = cclLeftToRightThenTopToBottom
      ChildSizing.ControlsPerLine = 1
      ClientHeight = 54
      ClientWidth = 232
      ItemIndex = 0
      Items.Strings = (
        'Synapse (open source, third-party)'
      )
      TabOrder = 0
    end
    object rgPersistencia: TRadioGroup
      Left = 472
      Height = 76
      Top = 0
      Width = 236
      Align = alLeft
      AutoFill = True
      Caption = 'Persistencia'
      ChildSizing.LeftRightSpacing = 6
      ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
      ChildSizing.EnlargeVertical = crsHomogenousChildResize
      ChildSizing.ShrinkHorizontal = crsScaleChilds
      ChildSizing.ShrinkVertical = crsScaleChilds
      ChildSizing.Layout = cclLeftToRightThenTopToBottom
      ChildSizing.ControlsPerLine = 1
      ClientHeight = 54
      ClientWidth = 232
      ItemIndex = 0
      Items.Strings = (
        'No usar'
        'TMemoryAfipPersister'
      )
      OnClick = rgPersistenciaClick
      TabOrder = 2
    end
    object rgJsonLibrary: TRadioGroup
      Left = 236
      Height = 76
      Top = 0
      Width = 236
      Align = alLeft
      AutoFill = True
      Caption = 'Biblioteca JSON'
      ChildSizing.LeftRightSpacing = 6
      ChildSizing.EnlargeHorizontal = crsHomogenousChildResize
      ChildSizing.EnlargeVertical = crsHomogenousChildResize
      ChildSizing.ShrinkHorizontal = crsScaleChilds
      ChildSizing.ShrinkVertical = crsScaleChilds
      ChildSizing.Layout = cclLeftToRightThenTopToBottom
      ChildSizing.ControlsPerLine = 1
      ClientHeight = 54
      ClientWidth = 232
      ItemIndex = 0
      Items.Strings = (
        'lkJson (open source, third-party)'
      )
      TabOrder = 1
    end
  end
  object SaveDialog1: TSaveDialog
    left = 406
    top = 150
  end
end
