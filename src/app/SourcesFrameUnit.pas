unit SourcesFrameUnit;

interface

uses
    System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms,
    FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
    TSourcesFrame = class(TFrame)
        BasePanel: TPanel;
        LeftPanel: TPanel;
        RightPanel: TPanel;
        LeftGrid: TGrid;
        LeftGridTitle: TStringColumn;
        LeftGridUnread: TIntegerColumn;
        LeftGridTotal: TIntegerColumn;
    private
        { Private declarations }
    public
        procedure RefreshData;
    end;

implementation

{$R *.fmx}

{ TSourcesFrame }

procedure TSourcesFrame.RefreshData;
begin
end;

end.
