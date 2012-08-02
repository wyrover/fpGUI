{
    << Impressions >>  U_ReportImages.pas

    Copyright (C) 2010 - Jean-Marc Levecque <jean-marc.levecque@jmlesite.fr>

   This library is a free software coming as a add-on to fpGUI toolkit
   See the copyright included in the fpGUI distribution for details about redistribution

   This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Description:
      This unit contains the images used by the preview dialog
}

unit U_ReportImages;

{$mode objfpc}

interface

uses
  fpg_main;

procedure CreateReportImages;
function DeleteReportImages: Boolean;

implementation

const
  repimg_Fin : Array[0..245] of byte = (
      66, 77,246,  0,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 16,  0,  0,  0, 16,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     128,  0,  0,  0, 18, 11,  0,  0, 18, 11,  0,  0,  0,  0,  0,  0, 16,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,192,192,192,
       0,128,128,128,  0,  0,  0,255,  0,  0,255,  0,  0,  0,255,255,  0,
     255,  0,  0,  0,255,  0,255,  0,255,255,  0,  0,255,255,255,  0,119,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,113,
     119,119,116, 71,119,119,119,113, 23,119,116, 71,119,119,119,113, 17,
     119,116, 71,119,119,119,113, 17, 23,116, 71,119,119,119,113, 17, 17,
     116, 71,119,119,119,113, 17, 23,116, 71,119,119,119,113, 17,119,116,
      71,119,119,119,113, 23,119,116, 71,119,119,119,113,119,119,116, 71,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,
     119,119,119,119,119,119,119,119);

const
  repimg_Imprimante : Array[0..357] of byte = (
      66, 77,102,  1,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 20,  0,  0,  0, 20,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     240,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,192,192,192,
       0,128,128,128,  0,  0,  0,255,  0,  0,255,  0,  0,  0,255,255,  0,
     255,  0,  0,  0,255,  0,255,  0,255,255,  0,  0,255,255,255,  0, 51,
      51, 51, 51, 51, 51, 51, 51, 51, 51,  0,  0, 51, 51, 51, 51, 51, 51,
      51, 51, 51, 51,  0,  0, 51,  0,  3, 51, 51, 51, 51, 48,  0, 51,  0,
       0, 48,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0, 48,247,119,119,
     119,119,119,119,119,  3,  0,  0, 48,247,119,119,119,119,119,119,119,
       3,  0,  0, 48,247,119,119,119,119,119,153,119,  3,  0,  0, 48,255,
     255,255,255,255,255,255,255,  3,  0,  0, 56,  0,136,136,136,136,136,
     136,  0,131,  0,  0, 51, 48,  0,  0,  0,  0,  0,  0,  3, 51,  0,  0,
      51, 48,136,136,136,136,136,136,  3, 51,  0,  0, 51, 48,  0,  0,  0,
       0,  0,  0,  3, 51,  0,  0, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51,
       0,  0, 51, 51, 51, 51, 51, 51, 56,  0,  8, 51,  0,  0, 51, 51, 51,
      51, 51, 51, 48,239,224, 51,  0,  0, 51, 56,  0,  0,  0,  0, 14,240,
       8, 51,  0,  0, 51, 48,224,239,239,239, 63,224, 51, 51,  0,  0, 51,
      56,  0,  0,  0,  0, 14,240,  8, 51,  0,  0, 51, 51, 51, 51, 51, 51,
      48,239,224, 51,  0,  0, 51, 51, 51, 51, 51, 51, 56,  0,  8, 51,  0,
       0);

const
  repimg_Precedent : Array[0..245] of byte = (
      66, 77,246,  0,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 16,  0,  0,  0, 16,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     128,  0,  0,  0, 18, 11,  0,  0, 18, 11,  0,  0, 16,  0,  0,  0, 16,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,128,128,128,
       0,192,192,192,  0,  0,  0,255,  0,192,192,192,  0,  0,255,255,  0,
     255,  0,  0,  0,192,192,192,  0,255,255,  0,  0,255,255,255,  0,218,
     218,218,218,218,218,218,218,173,173,173,173,173,173,173,173,218,218,
     218,218,218,218,218,218,173,173,173,173,173,173,173,173,218,218,218,
     218,209,218,218,218,173,173,173,173, 17,173,173,173,218,218,218,209,
      17,218,218,218,173,173,173, 17, 17,173,173,173,218,218,209, 17, 17,
     218,218,218,173,173,173, 17, 17,173,173,173,218,218,218,209, 17,218,
     218,218,173,173,173,173, 17,173,173,173,218,218,218,218,209,218,218,
     218,173,173,173,173,173,173,173,173,218,218,218,218,218,218,218,218,
     173,173,173,173,173,173,173,173);

const
  repimg_Stop : Array[0..245] of byte = (
      66, 77,246,  0,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 16,  0,  0,  0, 16,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,192,192,192,
       0,128,128,128,  0,  0,  0,255,  0,  0,255,  0,  0,  0,255,255,  0,
     255,  0,  0,  0,255,  0,255,  0,255,255,  0,  0,255,255,255,  0, 51,
      35,153,153,153,153, 34, 35, 51, 41,153,153,153,153,147, 51, 50,153,
     153,153,153,153,153, 51, 41,153,153,153,153,153,153,147,153,255,153,
     249,159,153,249,153,159,153,249,249,249,249,249,153,153,153,249,249,
     249,249,249,153,153,159,153,249,249,249,255,153,153,249,153,249,249,
     249,249,249,159,153,153,249,249,249,249,249,159,153,249,249,249,249,
     249,249,153,255,159,255,159,153,255,153, 57,153,153,153,153,153,153,
     147, 51,153,153,153,153,153,153, 51, 51, 57,153,153,153,153,147, 51,
      51, 51,153,153,153,153, 51, 51);

const
  repimg_Suivant : Array[0..245] of byte = (
      66, 77,246,  0,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 16,  0,  0,  0, 16,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     128,  0,  0,  0, 18, 11,  0,  0, 18, 11,  0,  0, 16,  0,  0,  0, 16,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,128,128,128,
       0,192,192,192,  0,  0,  0,255,  0,192,192,192,  0,  0,255,255,  0,
     255,  0,  0,  0,192,192,192,  0,255,255,  0,  0,255,255,255,  0,218,
     218,218,218,218,218,218,218,173,173,173,173,173,173,173,173,218,218,
     218,218,218,218,218,218,173,173,173,173,173,173,173,173,218,218,218,
      26,218,218,218,218,173,173,173, 17,173,173,173,173,218,218,218, 17,
      26,218,218,218,173,173,173, 17, 17,173,173,173,218,218,218, 17, 17,
      26,218,218,173,173,173, 17, 17,173,173,173,218,218,218, 17, 26,218,
     218,218,173,173,173, 17,173,173,173,173,218,218,218, 26,218,218,218,
     218,173,173,173,173,173,173,173,173,218,218,218,218,218,218,218,218,
   173,173,173,173,173,173,173,173);

const
  repimg_Debut : Array[0..245] of byte = (
      66, 77,246,  0,  0,  0,  0,  0,  0,  0,118,  0,  0,  0, 40,  0,  0,
       0, 16,  0,  0,  0, 16,  0,  0,  0,  1,  0,  4,  0,  0,  0,  0,  0,
     128,  0,  0,  0, 18, 11,  0,  0, 18, 11,  0,  0,  0,  0,  0,  0, 16,
       0,  0,  0,  0,  0,  0,  0,  0,  0,128,  0,  0,128,  0,  0,  0,128,
     128,  0,128,  0,  0,  0,128,  0,128,  0,128,128,  0,  0,192,192,192,
       0,128,128,128,  0,  0,  0,255,  0,  0,255,  0,  0,  0,255,255,  0,
     255,  0,  0,  0,255,  0,255,  0,255,255,  0,  0,255,255,255,  0,119,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119, 68,
     119,119,113,119,119,119,119, 68,119,119, 17,119,119,119,119, 68,119,
     113, 17,119,119,119,119, 68,119, 17, 17,119,119,119,119, 68,113, 17,
      17,119,119,119,119, 68,119, 17, 17,119,119,119,119, 68,119,113, 17,
     119,119,119,119, 68,119,119, 17,119,119,119,119, 68,119,119,113,119,
     119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,119,
     119,119,119,119,119,119,119,119);

procedure CreateReportImages;
begin

  fpgImages.AddMaskedBMP('repimg.Last',@repimg_Fin,sizeof(repimg_Fin),0,0);

  fpgImages.AddMaskedBMP('repimg.Printer',@repimg_Imprimante,sizeof(repimg_Imprimante),0,0);

  fpgImages.AddMaskedBMP('repimg.Precedent',@repimg_Precedent,sizeof(repimg_Precedent),0,0);

  fpgImages.AddMaskedBMP('repimg.Stop',@repimg_Stop,sizeof(repimg_Stop),0,0);

  fpgImages.AddMaskedBMP('repimg.Next',@repimg_Suivant,sizeof(repimg_Suivant),0,0);

  fpgImages.AddMaskedBMP('repimg.First',@repimg_Debut,sizeof(repimg_Debut),0,0);

end;

function DeleteReportImages: Boolean;
begin

  fpgImages.DeleteImage('repimg.Last',True);

  fpgImages.DeleteImage('repimg.Printer',True);

  fpgImages.DeleteImage('repimg.Precedent',True);

  fpgImages.DeleteImage('repimg.Stop',True);

  fpgImages.DeleteImage('repimg.Next',True);

  fpgImages.DeleteImage('repimg.First',True);

end;

end.
