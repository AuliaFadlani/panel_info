unit uPanelInfo;

interface

Uses
  Vcl.StdCtrls, Vcl.Forms, SysUtils, Vcl.Dialogs, Winapi.Windows, System.Classes, Vcl.Controls,
  Vcl.ExtCtrls, Vcl.graphics;

type

  TPanelInfo = class
    Timer1: TTimer;
  protected
    { Protected declarations }
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    LabelKu, lbl: TLabel;
    RoundedPanel, TrianglePanel: TPanel;
    LamaTampil: byte;
    Counter: byte;
    procedure LabelProperties(LabelName: TLabel);
    procedure PanelProperties(TrianglePanelName, RoundedPanel: TPanel);
    procedure RoundRectangleRegionPanel(PanelName: TPanel);
    procedure PanelSegitiga(PanelName: TPanel; EditName: TObject; Position: String);
    procedure ShowInformationPanel(PanelName, TrianglePanelName: TPanel;
      LabelName: TLabel; TrianglePosition, Kata: String);
    procedure TampilkanPanelInformasi(PanelName, TrianglePanelName: TPanel;
      edName: TObject; LabelName: TLabel; TrianglePosition, Kata: String);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Show(CompName: TObject; Teks, Posisi: String; Interval: byte);
    procedure Hide;
  end;

  { how to use:
    1. add "uPanelInfo.pas" into your project

    2. create a global variable:
       var
         pInfo: TPanelInfo;

    3. "create object"
       procedure TForm1.FormCreate(Sender: TObject);
       begin
         pInfo := TPanelInfo.Create(Self);
       end;

    4. "show the panel info"
       pInfo.Show(Sender, 'Minimal 3 Karakter', 'BOTTOM', 5)
       or
       pInfo.Show(Edit1, 'The text you want to show', 'TOP', 10)

    5. "hide the panel info"
       pInfo.hide;

    6. "remove object"
       procedure TForm1.FormDestroy(Sender: TObject; var Action: TCloseAction);
      begin
        pInfo.Destroy;
      end;

    video:
      https://www.youtube.com/watch?v=_E-E3rBEetU

    cara membuat panel menjadi segitiga dan ujungnya menjadi bundar
    saya lupa darimana sumbernya, rasanya dari swissdelphicenter...
    thanks buat yang membagi koding tersebut.

    *note:
      jika terjadi sesuatu yang tidak diharapkan terhadap project anda
      setelah menggunakan file "uPanelInfo.pas" maka resikonya ditanggung sendiri.
  }

implementation

procedure TPanelInfo.RoundRectangleRegionPanel(PanelName: TPanel);
var
  rgn: HRGN;
begin
  rgn := CreateRoundRectRgn(0,  // x-coordinate of the region's upper-left corner
    0,                          // y-coordinate of the region's upper-left corner
    PanelName.Width,               // x-coordinate of the region's lower-right corner
    PanelName.Height,              // y-coordinate of the region's lower-right corner
    3,                          // height of ellipse for rounded corners
    3);                         // width of ellipse for rounded corners

  PanelName.BringToFront;
  SetWindowRgn(PanelName.Handle, rgn, True);
end;

procedure TPanelInfo.ShowInformationPanel(PanelName, TrianglePanelName: TPanel;
  LabelName: TLabel; TrianglePosition, Kata: String);
begin
  PanelName.BringToFront;

  if Length(Kata) > 0 then
  begin
    lbl.Caption := kata;

    if (lbl.Width > 225) then
    begin
      LabelName.Height := (LabelName.Width div 225) * 16;
      LabelName.WordWrap := true;
      LabelName.Width := 225;
    end
    else
    begin
      LabelName.Height := 16;
      LabelName.WordWrap := false;
    end;

    LabelName.Caption := lbl.Caption;
    PanelName.Width := LabelName.Width + 20;
    PanelName.Height := LabelName.Height + 9;

    if TrianglePosition = 'BOTTOM' then
    begin
      PanelName.Top := TrianglePanelName.Top + TrianglePanelName.Height;
      PanelName.Left := TrianglePanelName.Left - 10;
    end
    else if TrianglePosition = 'TOP' then
    begin
      PanelName.Top := TrianglePanelName.Top - PanelName.Height + 2;
      PanelName.Left := TrianglePanelName.Left - 10;
    end
    else if TrianglePosition = 'LEFT' then
    begin
      PanelName.Top := TrianglePanelName.Top - ((PanelName.Height - TrianglePanelName.Height) div 2);
      PanelName.Left := TrianglePanelName.Left - PanelName.Width + 1;
    end
    else
    begin
      PanelName.Top := TrianglePanelName.Top - ((PanelName.Height - TrianglePanelName.Height) div 2);
      PanelName.Left := TrianglePanelName.Left + TrianglePanelName.Width;
    end;

    LabelName.Left := (PanelName.Width - LabelName.Width) div 2;
    LabelName.Top := 3;
  end;
  PanelName.Show;
end;

procedure TPanelInfo.LabelProperties(LabelName: TLabel);
begin
  with LabelName do
  begin
    Font.Name := 'Arial';
    Font.Color := clWhite;
    Font.Size := 10;
  end;
end;

procedure TPanelInfo.PanelProperties(TrianglePanelName,
  RoundedPanel: TPanel);
begin
  with TrianglePanelName do
  begin
    BevelInner := bvNone;
    BevelKind := bkNone;
    BevelOuter := bvNone;
    Caption := '';
    ShowCaption := False;
    Color := clBlack;
    ParentBackground := False;
  end;

  with RoundedPanel do
  begin
    BevelInner := bvNone;
    BevelKind := bkNone;
    BevelOuter := bvNone;
    Caption := '';
    ShowCaption := False;
    Color := clBlack;
    ParentBackground := False;
  end;
end;

procedure TPanelInfo.PanelSegitiga(PanelName: TPanel; EditName: TObject;
  Position: String);
var
  Points: array [0..2] of TPoint;
  h, w: SmallInt;
  w1, h1: SmallInt;
  komponen: TControl;
begin
  h := 6;
  w := 12;
  w1 := h;
  h1 := w;

  komponen := TControl(EditName);

  if (Position = 'LEFT') or (Position = 'RIGHT') then
  begin
    PanelName.Height := w;
    PanelName.Width := h;
    PanelName.Top := komponen.Top + ((komponen.Height - PanelName.Height) div 2);

    if komponen.Parent.ClassParent <> TForm then
      PanelName.Top := PanelName.Top + komponen.Parent.Top;
  end
  else
  begin
    PanelName.Height := h;
    PanelName.Width := w;
  end;

  if Position = 'BOTTOM' then
  begin
    Points[0].X := 0;       Points[0].Y := h;  // A
    Points[1].X := w div 2; Points[1].Y := 0;  // B
    Points[2].X := w;       Points[2].Y := h;  // C

    if komponen.Parent.ClassParent = TForm then
      PanelName.Top := komponen.Top + komponen.Height
    else  // jika parentnya adalah frame
      PanelName.Top := komponen.Top + komponen.Height + komponen.Parent.Top;
  end
  else if Position = 'TOP' then
  begin
    Points[0].X := 0;       Points[0].Y := 0;  // A
    Points[1].X := w;       Points[1].Y := 0;  // B
    Points[2].X := w div 2; Points[2].Y := h;  // C

    if komponen.Parent.ClassParent = TForm then
      PanelName.Top := komponen.Top - PanelName.Height
    else
      PanelName.Top := komponen.Top - PanelName.Height + komponen.Parent.Top;
  end
  else if Position = 'RIGHT' then
  begin
    Points[0].X := 0;       Points[0].Y := h1 div 2;  // A
    Points[1].X := w1;      Points[1].Y := 0;         // B
    Points[2].X := w1;      Points[2].Y := h1;        // C
  end
  else
  begin
    Points[0].X := 0;       Points[0].Y := 0;         // A
    Points[1].X := w1;      Points[1].Y := h1 div 2;  // B
    Points[2].X := 0;       Points[2].Y := h1;        // C
  end;

  if (Position = 'BOTTOM') or (Position = 'TOP') then
  begin
    if komponen.Parent.ClassParent = TForm then
      PanelName.Left := (komponen.Left + (komponen.Width div 2)) - (PanelName.Width div 2)
    else
      PanelName.Left := (komponen.left + komponen.Parent.left + (komponen.Width div 2)) - (PanelName.Width div 2)
  end
  else if (Position = 'LEFT') or (Position = 'RIGHT') then
  begin
    if komponen.Parent.ClassParent = TForm then
      PanelName.Left := (komponen.Left + komponen.Width)
    else
      PanelName.Left := (komponen.Left + komponen.Width) + komponen.Parent.Left;

    if Position = 'LEFT' then
      PanelName.Left := PanelName.Left - komponen.Width - 5;
  end;

  SetWindowRgn(PanelName.Handle, CreatePolygonRgn(Points, 3, WINDING), True);
  PanelName.Show;
end;

procedure TPanelInfo.TampilkanPanelInformasi(PanelName, TrianglePanelName: TPanel;
  edName: TObject; LabelName: TLabel; TrianglePosition, Kata: String);
begin
  LabelProperties(LabelName);
  PanelProperties(TrianglePanelName, PanelName);
  PanelSegitiga(TrianglePanelName, edName, TrianglePosition);
  ShowInformationPanel(PanelName, TrianglePanelName, LabelName, TrianglePosition, Kata);
  RoundRectangleRegionPanel(PanelName);
end;

constructor TPanelInfo.create(AOwner: TComponent);
begin
  inherited create;
  try
    RoundedPanel := TPanel.Create(AOwner);
    labelku := tlabel.Create(AOwner);
    lbl := TLabel.Create(AOwner);
    LabelProperties(lbl);
    TrianglePanel := TPanel.Create(AOwner);

    Timer1 := TTimer.Create(nil);
    with Timer1 do
    begin
      Enabled := False;
      Interval := 1000;
      OnTimer := Timer1Timer; // pada saat OnTimer, maka memanggil procedure Timer1Timer
    end;

    Counter := 0;
  except
    on e: exception do
      ShowMessage('Failed to create object! ' + e.Message);
  end;
end;

destructor TPanelInfo.Destroy;
begin
  FreeAndNil(Timer1);
  FreeAndNil(lbl);
  //FreeAndNil(TrianglePanel);
  //FreeAndNil(Labelku);
  //FreeAndNil(RoundedPanel);
  inherited Destroy;
end;

procedure TPanelInfo.Hide;
begin
  RoundedPanel.Hide;
  TrianglePanel.Hide;
  Timer1.Enabled := False;
  Counter := 0;
end;

procedure TPanelInfo.Show(CompName: TObject; Teks, Posisi: String; Interval: byte);
begin
  try
    LamaTampil := Interval;
    if Counter <> 0 then
      Hide;

    if TControl(CompName).Parent.ClassParent = TForm then
    begin
      RoundedPanel.Parent := TControl(CompName).Parent;
      TrianglePanel.Parent := TControl(CompName).Parent;
    end
    else
    begin
      RoundedPanel.Parent := TControl(TControl(CompName).Parent).Parent;
      TrianglePanel.Parent := TControl(TControl(CompName).Parent).Parent;
    end;

    labelku.Parent := RoundedPanel;
    Timer1.Enabled := True;

    TampilkanPanelInformasi(RoundedPanel, TrianglePanel, TControl(CompName), Labelku,
      Posisi, Teks);
  except
    ShowMessage('Something wrong with panel info...');
  end;
end;

procedure TPanelInfo.Timer1Timer(Sender: TObject);
begin
  Inc(Counter);
  if Counter >= LamaTampil then
    Hide;
end;

end.
