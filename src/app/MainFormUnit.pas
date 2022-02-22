unit MainFormUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
    FMX.Dialogs, FMX.Menus, FMX.DialogService, FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl;

type
    TMainForm = class(TForm)
        MainMenu: TMainMenu;
        ApplicationMenuItem: TMenuItem;
        ExitMenuItem: TMenuItem;
        ToolBar: TToolBar;
        StatusBar: TStatusBar;
        MainTabControl: TTabControl;
        SourcesTabItem: TTabItem;
        CategoriesTabItem: TTabItem;
        TagsTabItem: TTabItem;
        VideosTabItem: TTabItem;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        ViewMenuItem: TMenuItem;
        SourcesMenuItem: TMenuItem;
        CategoriesMenuItem: TMenuItem;
        TagsMenuItem: TMenuItem;
        VideosMenuItem: TMenuItem;
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExitMenuItemClick(Sender: TObject);
    procedure SourcesMenuItemClick(Sender: TObject);
    procedure CategoriesMenuItemClick(Sender: TObject);
    procedure TagsMenuItemClick(Sender: TObject);
    procedure VideosMenuItemClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;

implementation

uses
    SourcesFrameUnit;

{$R *.fmx}

var
    SourcesFrame: TSourcesFrame;

procedure TMainForm.FormCreate(Sender: TObject);
begin
    MainTabControl.TabPosition := TTabPosition.None;
    SourcesFrame := TSourcesFrame.Create(nil);
    SourcesFrame.Parent := SourcesTabItem;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    CanCloseLocal: Boolean;
begin
    CanCloseLocal := CanClose;
    TDialogService.MessageDialog('Exit application?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
        procedure (const AResult: TModalResult)
        begin
            if AResult = mrNo
            then CanCloseLocal := False;
        end);
    CanClose := CanCloseLocal;
end;

procedure TMainForm.ExitMenuItemClick(Sender: TObject);
begin
    Close;
end;

procedure TMainForm.SourcesMenuItemClick(Sender: TObject);
begin
    SourcesFrame.RefreshData;
    MainTabControl.ActiveTab := SourcesTabItem;
end;

procedure TMainForm.CategoriesMenuItemClick(Sender: TObject);
begin
    MainTabControl.ActiveTab := CategoriesTabItem;
end;

procedure TMainForm.TagsMenuItemClick(Sender: TObject);
begin
    MainTabControl.ActiveTab := TagsTabItem;
end;

procedure TMainForm.VideosMenuItemClick(Sender: TObject);
begin
    MainTabControl.ActiveTab := VideosTabItem;
end;

end.
