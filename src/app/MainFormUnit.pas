unit MainFormUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
    FMX.Dialogs, FMX.Menus, FMX.DialogService, FMX.Controls.Presentation, FMX.StdCtrls;

type
    TMainForm = class(TForm)
        MainMenu: TMainMenu;
        ApplicationMenuItem: TMenuItem;
        ExitMenuItem: TMenuItem;
    ToolBar: TToolBar;
        procedure ExitMenuItemClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
//
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//
end;

procedure TMainForm.ExitMenuItemClick(Sender: TObject);
begin
    TDialogService.MessageDialog('Exit application?', TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
        procedure (const AResult: TModalResult)
        begin
            if AResult = mrYes
            then Close;
        end);
end;

end.
