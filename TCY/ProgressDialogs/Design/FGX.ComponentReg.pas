{*********************************************************************
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 *
 ********************************************************************}

unit FGX.ComponentReg;

interface

procedure Register;

implementation

uses
  System.Classes,
  DesignIntf,
  FMX.Graphics,
  FGX.ActionSheet, FGX.VirtualKeyboard, FGX.ProgressDialog, FGX.GradientEdit, FGX.ColorsPanel, FGX.LinkedLabel,
  FGX.Items, FGX.Consts;

procedure Register;
begin
  { Components Registration }
  RegisterComponents(rsCategoryExtended, [TfgActionSheet, TfgVirtualKeyboard, TfgProgressDialog, TfgActivityDialog,
    TfgGradientEdit, TfgColorsPanel, TfgLinkedLabel]);
end;

end.
