{
--------------------------------------------------------------------
Copyright (c) 2009 KSP Developers Team
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit KSPCrossList;

interface

uses SysUtils, Classes;

type TCrossEntry = class
      SubList: TStringList;
      Name: string;
    public
      constructor Create;
      destructor Destroy;
  end;

type TCrossList = class(TList)
      fEntry: TCrossEntry;
    public
      procedure Add(name: string);
      destructor Destroy;
      property Entry: TCrossEntry read fEntry write fEntry;
      procedure Sort;
    end;

implementation

function CompareName(Item1, Item2: Pointer): integer;
begin
  Result := CompareText(TCrossEntry(Item1).Name, TCrossEntry(Item2).Name);
end;

procedure TCrossList.Sort;
var
  i: integer;
begin
  inherited Sort(@CompareName);
  if Count>0 then
    for i:=0 to Count-1 do
      TCrossEntry(Items[i]).SubList.Sort;
end;

procedure TCrossList.Add(name: string);
var
  T: TCrossEntry;
begin
  T:=TCrossEntry.Create;
  T.Name:=name;
  inherited Add(T);
end;

constructor TCrossEntry.Create;
begin
  inherited Create;
  SubList:=TStringList.Create;
end;

destructor TCrossEntry.Destroy;
begin
  SubList.Free;
  inherited Destroy;
end;

destructor TCrossList.Destroy;
var
  i: integer;
begin
  if Count>0 then
    for i:=0 to Count-1 do
      TCrossEntry(Items[i]).Free;
  inherited Destroy;
end;

end.
