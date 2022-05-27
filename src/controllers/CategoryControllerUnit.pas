unit CategoryControllerUnit;

interface

uses
    System.SysUtils, System.Generics.Collections, CategoryUnit;

type
    TCategoryController = class
    public
        class function FindAll: TObjectList<TCategory>;
        class function FindNotEmpty: TObjectList<TCategory>;
        class function FindById(AId: String): TCategory;
    end;

implementation

uses
    CategoryRepositoryUnit;

{ TCategoryController }

class function TCategoryController.FindAll: TObjectList<TCategory>;
begin
    Result := TCategoryRepository.FindAll;
end;

class function TCategoryController.FindNotEmpty: TObjectList<TCategory>;
begin
    Result := TCategoryRepository.FindNotEmpty;
end;

class function TCategoryController.FindById(AId: String): TCategory;
begin
    Result := TCategoryRepository.FindById(AId);
end;

end.
