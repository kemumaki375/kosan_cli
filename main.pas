uses crt ;

CONST TOTAL_ROOM = 1000 ;
{ Maksimal Jumlah Kamar }

CONST Xs = 10   ;

CONST Ys = 6  ;


TYPE
date = record
       tgl : integer ;
       bln : integer ;
       thn : integer;
       end;
user = record
       id : longint ;
       first_name  : string ;
       last_name : string ;
       no_identitas : string ;
       datein :  date ;
       alamat : string ;
       telp : string ;
       telp_ot : string ;
       status : boolean ;
       no_kamar : integer ;
       lama : integer ;
       end;

var
f : text ;
fetch : longint ;

procedure dcl(x:integer;y:integer);
begin
gotoxy(x,y);clreol;
end;

procedure delayed_print(delay : integer ; text : string )    ;
var i,a,b : integer ;
begin
for i:=1 to length(text) do
begin
for a:=1 to delay do
for b:=1 to 10000 do;
write(text[i]);
end;
end;

procedure print_red(s:string);
begin
textbackground(red);
writeln(s);
textbackground(black);
end;

procedure print_blue(s:string);
begin
textbackground(blue);
writeln(s);
textbackground(black);
end;

procedure print_green(s:string);
begin
textbackground(green);
writeln(s);
textbackground(black);
end;

procedure pgreen(x:integer;s:string);
begin
textcolor(green);
delayed_print(x,s);
textcolor(white);
end;

procedure pblue(x:integer;s:string);
begin
textcolor(blue);
delayed_print(x,s);
textcolor(white);
end;

procedure pred(x:integer;s:string);
begin
textcolor(red);
delayed_print(x,s);
textcolor(white);
end;




function get_total_room : longint ;
var sum : longint ;
var a,b,c,d : integer ;
f1 : text ;
begin
assign(f1,'data_kamar.txt');
reset(f1);
sum := 0 ;
while not eof(f1) do
begin
  sum := sum + 1 ;
 readln(f1,a,b,c);
end;
get_total_room := sum ;
close(f1);
end;

function validate_choice(input : string;sum : integer)  : integer ;
var
code : word ;
out : integer ;
dum : longint;
begin
val(input,dum,code);
if code > 0 then
begin
   validate_choice := -1 ;
end else

if (dum>0) and ( dum<=sum) then
validate_choice := dum else validate_choice:= -1 ;
end;

function isblank(x:string) : boolean   ;
begin
   if length(x) > 0 then isblank := false else
   isblank := true ;
end;

function isnumber(x : string) : integer ;
var
code : word ;
dum : longint;
begin
val(x,dum,code);
if code > 0 then
begin
   isnumber := -1 ;
end else
isnumber := dum ;
end;

function is_yesornot(x:string) : boolean ;
var dum : string ;
begin
is_yesornot := false ;
if( (x[1] = 'y') or (x[1] = 'Y') or (x[1] = 'N') or (x[1] = 'n') ) then
   is_yesornot := true ;
if (length(x) <> 1) then is_yesornot := false ;
end;

function is_leapyear(x : integer ) : boolean ;
begin
if (x mod 100) = 0 then
 begin
   if ( x mod 400 ) = 0 then is_leapyear := true else is_leapyear := false
 end else
 begin
  if ( x mod 4 ) = 0 then is_leapyear := true else is_leapyear := true ;
 end;
end;


function get_total_occupant : integer;
var f1:text;
count : integer ;
x : string;
begin
assign(f1,'data_first_name_anak.txt');
reset(f1);
count := 0;
while not eof(f1) do
begin
   readln(f1,x);
   inc(count);
end;
get_total_occupant := count;
close(f1);
end;

function get_total_user : integer;
var f1:text;
count : integer ;
x : string;
begin
assign(f1,'username.txt');
reset(f1);
count := 0;
while not eof(f1) do
begin
   readln(f1,x);
   inc(count);
end;
get_total_user := count;
close(f1);
end;

procedure copy_file(var input : text;var output:text);
var x : string;
begin
while not eof(input) do
begin
  readln(input,x);
  writeln(output,x);
end;
end;

procedure copy_3file(var input : text;var output:text);
var a,b,c : integer ;
begin
while not eof(input) do
begin
  readln(input,a,b,c);
  writeln(output,a,' ',b,' ',c);
end;
end;

function auth_user(a,b : string) : integer ;
var f1,f2 : text;
x,y : string;
cnt : integer;
begin
assign(f1,'username.txt');
reset(f1);
assign(f2,'password.txt');
reset(f2);
cnt := 0 ;
auth_user := -1 ;
while not eof(f1) do
begin
   inc(cnt);
   readln(f1,x);
   readln(f2,y) ;
   if (x=a) and (y=b) then
   begin
      auth_user:=cnt  ;
      break;
   end;
end;
close(f1);
close(f2);
end;

procedure add_user(a,b : string );
var
f1,f2 : text;
begin
assign(f1,'username.txt');
append(f1);
assign(f2,'password.txt');
append(f2);
writeln(f1,a);
writeln(f2,b);
close(f1);
close(f2);
end;

procedure delete_user( id : integer);
var
fa,fb,f1,f2 : text;
a,b : string;
ctr : integer ;
begin
assign(f1,'username.txt');
reset(f1);
assign(fa,'dum_username.txt');
rewrite(fa);
copy_file(f1,fa);
reset(fa);
rewrite(f1);

assign(f2,'password.txt');
reset(f2);
assign(fb,'dum_password.txt');
rewrite(fb);
copy_file(f2,fb);
reset(fb);
rewrite(f2);

while not eof(fa) do
begin
   inc(ctr);
   readln(fa,a);
   readln(fb,b);
   if not (ctr=id) then
   begin
      writeln(f1,a);
      writeln(f2,b);
   end;
end;
close(f1);
close(f2);
close(fa);
close(fb);
end;

procedure change_pay_stat(x: integer);
var i : integer ;
var fa,fb : text ;
stat : string;
counter : integer ;
begin
counter := 0 ;
assign(fa,'data_pembayaran_anak.txt');
reset(fa);
assign(fb,'dum_pembayaran_anak.txt');
rewrite(fb);

copy_file(fa,fb);
rewrite(fa);
reset(fb);
while not eof(fb) do
begin
   readln(fb,stat);
   inc(counter);
   if counter = x then
   begin
    if stat='TRUE' then writeln(fa,'FALSE') else writeln(fa,'TRUE');
   end else writeln(fa,stat);
end;
close(fa);
erase(fb);
close(fb);
end;

procedure change_room_stat(x: integer);
var i : integer ;
var fa,fb : text ;
a,b,c : integer ;
counter : integer ;
begin
counter := 0 ;
assign(fa,'data_kamar.txt');
reset(fa);
assign(fb,'dum_kamar.txt');
rewrite(fb);
copy_file(fa,fb);
rewrite(fa);
reset(fb);
while not eof(fb) do
begin
   readln(fb,a,b,c);
   inc(counter);
   if counter = x then
   begin
   if c=0 then writeln(fa,a,' ',b,' ',1) else writeln(fa,a,' ',b,' ',0)
   end else writeln(fa,a,' ',b,' ',c);
end;
close(fa);
erase(fb);
close(fb);
end;

procedure alter_field_entry(field:integer; id : integer; entry : string );
var
f,f2 : text ;
x : string ;
ctr : integer ;
a,b,c : integer ;
newdate : integer ;
code : integer ;
xx : integer ;
xentry : integer;
begin
val(entry,newdate,code);
if field = 1 then
begin
   assign(f,'data_first_name_anak.txt');
   reset(f);
end else
if field = 2 then
begin
   assign(f,'data_last_name_anak.txt');
   reset(f);
end else
if field = 3 then
begin
   assign(f,'data_ktp_anak.txt');
   reset(f);
end else
if (field = 4) or (field=5) or (field=6) then
begin
   assign(f,'data_datein_anak.txt');
   reset(f);
end else

if field = 7 then
begin
   assign(f,'data_alamat_anak.txt');
   reset(f);
end else
if field = 8 then
begin
   assign(f,'data_telp_anak.txt');
   reset(f);
end else
if field = 9 then
begin
   assign(f,'data_telp_ot_anak.txt');
   reset(f);
end else
if field = 10 then
begin
   assign(f,'data_no_kamar_anak.txt');
   reset(f);
end else
if field = 11 then
begin
   assign(f,'data_pembayaran_anak.txt');
   reset(f);
end else
if field =  12 then
begin
   assign(f,'data_lama_anak.txt');
   reset(f);
end;
if not ((field = 4) or (field=5) or (field=6)) then begin
assign(f2,'dum.txt');
rewrite(f2);
copy_file(f,f2);
rewrite(f);
reset(f2);
end else
 begin
assign(f2,'dum.txt');
rewrite(f2);
copy_3file(f,f2);
rewrite(f);
reset(f2);
end;
ctr:=0;
if not ((field = 4) or (field=5) or (field=6)) then begin
while not eof(f2) do
begin
   readln(f2,x);
   inc(ctr);
   if ctr = id then
   begin
   writeln(f,entry);
   if field = 10 then
    begin
       val(x,xx,code);
       val(entry,xentry,code)       ;
       change_room_stat(xx);
       change_room_stat(xentry);
    end;
   end else writeln(f,x);
end;
end else
   begin
      while not eof(f2) do
      begin
      readln(f2,a,b,c);
      inc(ctr);
      if ctr=id then
      begin
         if field=4 then writeln(f,newdate,' ',b,' ',c);
         if field=5 then writeln(f,a,' ',newdate,' ',c);
         if field=6 then writeln(f,a,' ',b,' ',newdate);
      end else writeln(f,a,' ',b,' ',c);
      end;
   end;
close(f);
erase(f2);
close(f2);
end;


procedure delete_field_data(id : integer;field:integer);
var
f,f2 : text ;
x : string ;
ctr : integer ;
a,b,c : integer ;
newdate : integer ;
code : integer ;
begin
if (field=5) or (field =6) then exit;
if field = 1 then
begin
   assign(f,'data_first_name_anak.txt');
   reset(f);
end else
if field = 2 then
begin
   assign(f,'data_last_name_anak.txt');
   reset(f);
end else
if field = 3 then
begin
   assign(f,'data_ktp_anak.txt');
   reset(f);
end else
if (field = 4)  then
begin
   assign(f,'data_datein_anak.txt');
   reset(f);
end else

if field = 7 then
begin
   assign(f,'data_alamat_anak.txt');
   reset(f);
end else
if field = 8 then
begin
   assign(f,'data_telp_anak.txt');
   reset(f);
end else
if field = 9 then
begin
   assign(f,'data_telp_ot_anak.txt');
   reset(f);
end else
if field = 10 then
begin
   assign(f,'data_no_kamar_anak.txt');
   reset(f);
end else
if field = 11 then
begin
   assign(f,'data_pembayaran_anak.txt');
   reset(f);
end else
if field =  12 then
begin
   assign(f,'data_lama_anak.txt');
   reset(f);
end else
if field = 13 then
begin
   assign(f,'password.txt');
   reset(f);
end else
if field = 14 then
begin
  assign(f,'username.txt');
  reset(f);
end;

if not ((field = 4) or (field=5) or (field=6)) then begin
assign(f2,'dum.txt');
rewrite(f2);
copy_file(f,f2);
rewrite(f);
reset(f2);
end else
 begin
assign(f2,'dum.txt');
rewrite(f2);
copy_3file(f,f2);
rewrite(f);
reset(f2);
end;
ctr:=0;

while not eof(f2) do
begin
   readln(f2,x);
   inc(ctr);
   if not(ctr = id) then
   begin
   writeln(f,x);
   end
end;

close(f);
erase(f2);
close(f2);
end;

procedure delete_data_anak( id : integer );
var i : integer;
begin
for i:= 1 to 12 do
begin
   delete_field_data(id,i);
end;

end;

procedure add_data_anak(fn : string;ln:string; no_identitas:string;datein:date;alamat:string;
telp:string;telp_ot:string;status:boolean;nokamar:integer;lama:integer);
var f1 : text ;
begin

assign(f1,'data_first_name_anak.txt');
append(f1);
writeln(f1,fn);
close(f1);

assign(f1,'data_last_name_anak.txt');
append(f1);
writeln(f1,ln);
close(f1);

assign(f1,'data_ktp_anak.txt');
append(f1);
writeln(f1,no_identitas);
close(f1);

assign(f1,'data_datein_anak.txt');
append(f1);
writeln(f1,datein.tgl,' ',datein.bln,' ',datein.thn);
close(f1);

assign(f1,'data_alamat_anak.txt');
append(f1);
writeln(f1,alamat);
close(f1);

assign(f1,'data_telp_anak.txt');
append(f1);
writeln(f1,telp);
close(f1);

assign(f1,'data_telp_ot_anak.txt');
append(f1);
writeln(f1,telp_ot);
close(f1);

assign(f1,'data_no_kamar_anak.txt');
append(f1);
writeln(f1,nokamar);
close(f1) ;
change_room_stat(nokamar);


assign(f1,'data_pembayaran_anak.txt');
append(f1);
writeln(f1,status);
close(f1);

assign(f1,'data_lama_anak.txt');
append(f1);
writeln(f1,lama);
close(f1)

end;


procedure show_data_anak(a,b,c:integer);
var f1,f2,f3,f4,f5,f6,f7,f8,f9,f10 : text ;
i,n : integer ;
fn,ln,ktp,datein,alamat,telp,telp_ot,no_kamar,lama : string;
pay_status : string ;
x : date ;
del : integer;
begin

n := get_total_occupant ;

assign(f1,'data_first_name_anak.txt');
reset(f1);

assign(f2,'data_last_name_anak.txt');
reset(f2);

assign(f3,'data_ktp_anak.txt');
reset(f3);

assign(f4,'data_datein_anak.txt');
reset(f4);

assign(f5,'data_alamat_anak.txt');
reset(f5);

assign(f6,'data_telp_anak.txt');
reset(f6);

assign(f7,'data_telp_ot_anak.txt');
reset(f7);

assign(f8,'data_no_kamar_anak.txt');
reset(f8);

assign(f9,'data_pembayaran_anak.txt');
reset(f9);

assign(f10,'data_lama_anak.txt');
reset(f10);


for i:=1 to n do
begin

readln(f1,fn);
readln(f2,ln);
readln(f3,ktp);
readln(f4,x.tgl,x.bln,x.thn);
readln(f5,alamat);
readln(f6,telp);
readln(f7,telp_ot);
readln(f8,no_kamar);
readln(f9,pay_status);
readln(f10,lama);
del:=0;
if ( i >= a) and ( i <= b ) and ( c=0 ) then
begin
 inc(del);
 gotoxy(xs,wherey);writeln('NO-ID : ',i);
 gotoxy(xs,wherey);writeln('---------------------------------------------');
 if c=0 then

 begin gotoxy(xs,wherey);writeln('Nama Lengkap            : ',fn,' ',ln)   end
 else if c= 1 then
 begin
   gotoxy(xs,wherey);writeln('Name Depan              : ',fn);
   gotoxy(xs,wherey);writeln('Nama Belakang           : ',ln);
 end;
 gotoxy(xs,wherey);writeln('No Identitas            : ',ktp);
 gotoxy(xs,wherey);writeln('Taggal Masuk           ');
 gotoxy(xs,wherey);writeln;
 gotoxy(xs,wherey);writeln('    - Tanggal           : ',x.tgl);
 gotoxy(xs,wherey);writeln('    - Bulan             : ',x.bln);
 gotoxy(xs,wherey);writeln('    - Tahun             : ',x.thn);
 gotoxy(xs,wherey);writeln;
 gotoxy(xs,wherey);writeln('Alamat Asal             : ',alamat);
 gotoxy(xs,wherey);writeln('No telepon pribadi      : ',telp);
 gotoxy(xs,wherey);writeln('No Telp Orang Tua       : ',telp_ot);
 gotoxy(xs,wherey);writeln('No Kamar yang ditempati : ',no_kamar);
 if (pay_status='TRUE') then
begin gotoxy(xs,wherey);writeln('Status Pembayaran       : Sudah Membayar ') end else
 begin gotoxy(xs,wherey);writeln('Status Pembayaran       : Belum Membayar'); end;
 gotoxy(xs,wherey);writeln('Lama Penyewaan          : ',lama, ' bulan');

 gotoxy(xs,wherey);writeln('---------------------------------------------');
 writeln;
 if (del>1) and (i<b) then
 begin
    gotoxy(xs,wherey);pgreen(0,'Tekan sembarang tombol untuk melanjutkan ... ');
    readkey;
 end;

 end else
if ( i >= a) and ( i <= b ) and ( c=1 ) then
begin
 gotoxy(xs,wherey);writeln('NO-ID : ',i);
 gotoxy(xs,wherey);writeln('---------------------------------------------');
 gotoxy(xs,wherey);writeln('[1] Name Depan               : ',fn);
 gotoxy(xs,wherey);writeln('[2] Nama Belakang            : ',ln);
 gotoxy(xs,wherey);writeln('[3] No Identitas             : ',ktp);
 gotoxy(xs,wherey);writeln('Tanggal Masuk            ');
 gotoxy(xs,wherey);writeln;
 gotoxy(xs,wherey);writeln('    [4] - Tanggal            : ',x.tgl);
 gotoxy(xs,wherey);writeln('    [5] - Bulan              : ',x.bln);
 gotoxy(xs,wherey);writeln('    [6] - Tahun              : ',x.thn);
 gotoxy(xs,wherey);writeln;
 gotoxy(xs,wherey);writeln('[7] Alamat Asal              : ',alamat);
 gotoxy(xs,wherey);writeln('[8] No telepon pribadi       : ',telp);
 gotoxy(xs,wherey);writeln('[9]  No Telp Orang Tua       : ',telp_ot);
 gotoxy(xs,wherey);writeln('[10] No Kamar yang ditempati : ',no_kamar);
 if (pay_status='TRUE') then
 begin gotoxy(xs,wherey);writeln('[11] Status Pembayaran       : Sudah Membayar ') end else
 begin gotoxy(xs,wherey);writeln('[11] Status Pembayaran       : Belum Membayar'); end;
 gotoxy(xs,wherey);writeln('[12] Lama Penyewaan          : ',lama, ' bulan');
 gotoxy(xs,wherey);writeln('---------------------------------------------');


end;

end;
close(f1);
close(f2);
close(f3);
close(f4);
close(f5);
close(f6);
close(f7);
close(f8);
close(f9);
close(f10);
end;
{ print to file belum support yang baru }
procedure print_to_file(file_name : string);
var f1,f2,f3,f4,f5,f6,f7,f8,f9,f10 : text ;
fn,ln,ktp,datein,alamat,telp,telp_ot,no_kamar : string;
pay_status,lama : string ;
fout : text ;
i,n : integer ;
x: date ;
begin
assign(fout,file_name);
rewrite(fout);

n := get_total_occupant ;

assign(f1,'data_first_name_anak.txt');
reset(f1);

assign(f2,'data_last_name_anak.txt');
reset(f2);

assign(f3,'data_ktp_anak.txt');
reset(f3);

assign(f4,'data_datein_anak.txt');
reset(f4);

assign(f5,'data_alamat_anak.txt');
reset(f5);

assign(f6,'data_telp_anak.txt');
reset(f6);

assign(f7,'data_telp_ot_anak.txt');
reset(f7);

assign(f8,'data_no_kamar_anak.txt');
reset(f8);

assign(f9,'data_pembayaran_anak.txt');
reset(f9);

assign(f10,'data_lama_anak.txt');
reset(f10);


for i:=1 to n do
begin

readln(f1,fn);
readln(f2,ln);
readln(f3,ktp);
readln(f4,x.tgl,x.bln,x.thn);
readln(f5,alamat);
readln(f6,telp);
readln(f7,telp_ot);
readln(f8,no_kamar);
readln(f9,pay_status);
readln(f10,lama);


 writeln(fout,'NO-ID : ',i);
 writlen(fout,'--------------------------------------------');
 writeln(fout,'Nama Lengkap            : ',fn,' ',ln) ;
 writeln(fout,'No Identitas            : ',ktp);
 writeln(fout,'Taggal Masuk           ');
    writeln(fout,'   - Tanggal    : ',x.tgl);
    writeln(fout,'   - Bulan      : ',x.bln);
    writeln(fout,'   - Tahun      : ',x.thn);
 writeln(fout,'Alamat Asal             : ',alamat);
 writeln(fout,'No telepon pribadi      : ',telp);
 writeln(fout,'No Telp Orang Tua       : ',telp_ot);
 writeln(fout,'No Kamar yang ditempati : ',no_kamar);
 if (pay_status='TRUE') then
 writeln(fout,'Status Pembayaran       : Sudah Membayar ') else
 writeln(fout,'Status Pembayaran       : Belum Membayar');
 writeln(fout,'Lama Penyewaan          : ',lama, ' bulan');
 writeln(fout,'---------------------------------------------');

end;
close(fout);
close(f1);
close(f2);
close(f3);
close(f4);
close(f5);
close(f6);
close(f7);
close(f8);
close(f9);
close(f10);
end;


procedure add_room(x : integer );
var i,a,y,num : integer ;
ans : string ;
f1 : text ;
now : integer ;
begin
now := get_total_room;
assign(f1,'data_kamar.txt');
append(f1);

for i := 1 to x do
begin
  gotoxy(xs,ys+6+i);write('Apakah kamar baru yang ke-',i,' ada kamar mandi dalamnya ? [y/n] ');
  gotoxy(xs+64,ys+6+i);readln(ans);
  while not is_yesornot(ans) do
  begin
     gotoxy(xs+64,ys+6+i);print_red('hanya boleh diinput huruf "y" atau "n"');
     readkey;
     dcl(xs+64,ys+6+i);
     gotoxy(xs+64,ys+6+i);readln(ans);
  end;
  if (ans='y') or (ans='Y') then a:= 1 else a:= 0 ;
  writeln(f1,i+now,' ',a,' ',0);
end;
close(f1);

end;



function check_avaible_room( n : integer )  : boolean;
var f1:text ;
var a,b,c : integer ;
var counter : integer ;
begin
counter := 0 ;
assign(f1,'data_kamar.txt');
reset(f1);
while not eof(f1) do
begin
   readln(f1,a,b,c);
   inc(counter);
   if counter = n then
   begin
      if c = 0 then check_avaible_room := true else check_avaible_room := false;
   end;
end;
close(f1);
end;

function get_name_from_id( id : integer ) : string;
var
f1,f2 : text ;
i : integer ;
a,b : string;
ctr : integer ;
begin
ctr := 0 ;
assign(f1,'data_first_name_anak.txt');
reset(f1);
assign(f2,'data_last_name_anak.txt');
reset(f2);
while not (eof(f1) and eof(f2)) do
begin
readln(f1,a);
readln(f2,b);
inc(ctr);
if ctr = id then
  begin
   get_name_from_id := a + ' ' + b ;
  end;
end;
close(f1);
close(f2);
end;

function get_room_from_id ( id : integer ) : integer;
var
f1 : text ;
n : integer ;
ctr : integer ;
begin
ctr :=0 ;
get_room_from_id := -1;
assign(f1,'data_no_kamar_anak.txt');
reset(f1);
while not(eof(f1)) do
begin
   readln(f1,n);
   inc(ctr);
   if id=ctr then
   begin
      get_room_from_id := n ;
      break;
   end;
end;
close(f1);
end;

function get_user_from_id ( id : integer ) : string;
var
f1 : text ;
n : string ;
ctr : integer ;
begin
ctr :=0 ;
assign(f1,'username.txt');
reset(f1);
while not(eof(f1)) do
begin
   readln(f1,n);
   inc(ctr);
   if id=ctr then
   begin
      get_user_from_id := n ;
      break;
   end;
end;
close(f1);
end;

function sum_avaible_room : integer ;
var f1:text ;
var a,b,c : integer ;
var counter : integer ;
begin
assign(f1,'data_kamar.txt');
reset(f1);
counter := 0;
while not eof(f1) do
begin
   readln(f1,a,b,c);
   if c = 0 then begin
   inc(counter);
   end;
end;
sum_avaible_room := counter;
close(f1);
end;

function get_name_from_room(x : integer) : string;
var
n : integer ;
count : integer;
get : boolean;
f1 : text ;
begin
get := false ;
count := 0;
get_name_from_room := '' ;
assign(f1,'data_no_kamar_anak.txt');
reset(f1);
while not eof(f1) do
begin
   readln(f1,n);
   inc(count);
   if n = x then get_name_from_room  := get_name_from_id(count);
end;
close(f1)
end;


function get_id_from_query(q : string) : integer;
var
f1,f2 : text ;
c1,c2 : string;
x : integer ;
dum1 : integer;
dum2 : integer;
begin
   q:=lowercase(q);
   x:= 0;
   get_id_from_query := -1 ;
   assign(f1,'data_first_name_anak.txt');
   reset(f1);
   assign(f2,'data_last_name_anak.txt');
   reset(f2);
   while not ( eof(f1) and eof(f2) ) do
   begin
     inc(x);
     readln(f1,c1);
     readln(f2,c2);
     c1 := lowercase(c1);
     c2 := lowercase(c2);
     dum1:= pos(q,c1);
     dum2:= pos(q,c2);
     if ( ((dum1>0) or (dum2>0)) and (x>fetch) ) then
     begin get_id_from_query := x ; fetch := x ;break end;
   end;
close(f1);
close(f2);
end;

function get_id_from_area(q : string) : integer ;
var
f1 : text ;
c: string;
x: integer;
dum : integer;
begin
   q:=lowercase(q);
   x:= 0;
   get_id_from_area := -1 ;
   assign(f1,'data_alamat_anak.txt');
   reset(f1);
   while not ( eof(f1) ) do
   begin
     inc(x);
     readln(f1,c);
     c := lowercase(c);
     dum:= pos(q,c);
     if ( ((dum>0) ) and (x>fetch) ) then
     begin get_id_from_area := x ; fetch := x ;break end;
   end;
close(f1);
end;

function get_pay_status_from_id(id :integer) : boolean ;
var
f1 : text;
c : string;
count : integer;
begin
   assign(f1,'data_pembayaran_anak.txt');
   reset(f1);
   count := 0;
   get_pay_status_from_id := false ;
   while not (eof(f1)) do
   begin
       inc(count);
       readln(f1,c);
       if count = id then
       begin
          if (c = 'TRUE') then get_pay_status_from_id := TRUE ;
       end;
   end ;
close(f1);
end;

function get_single_field_entry(field,id : integer ) : string;
var
f : text ;
x : string ;
ctr : integer ;
a,b,c : integer ;
begin
if field = 1 then
begin
   assign(f,'data_first_name_anak.txt');
   reset(f);
end else
if field = 2 then
begin
   assign(f,'data_last_name_anak.txt');
   reset(f);
end else
if field = 3 then
begin
   assign(f,'data_ktp_anak.txt');
   reset(f);
end else
if ( field >=4 ) and ( field <=6 ) then
begin
   assign(f,'data_datein_anak.txt');
   reset(f);
end else

if field = 7 then
begin
   assign(f,'data_alamat_anak.txt');
   reset(f);
end else
if field = 8 then
begin
   assign(f,'data_telp_anak.txt');
   reset(f);
end else
if field = 9 then
begin
   assign(f,'data_telp_ot_anak.txt');
   reset(f);
end else
if field = 10 then
begin
   assign(f,'data_no_kamar_anak.txt');
   reset(f);
end else
if field = 11 then
begin
   assign(f,'data_pembayaran_anak.txt');
   reset(f);
end else
if field = 12 then
begin
   assign(f,'data_lama_anak.txt');
   reset(f);
end;
ctr := 0 ;
if not (( field >=4 ) and ( field <=6 )) then begin
while not eof(f) do
begin
   inc(ctr);
   readln(f,x);
  if id = ctr then
  begin
     get_single_field_entry :=  x ;
     break ;
  end
end;
end else
begin
   while not eof(f) do
   begin
      inc(ctr);
      readln(f,a,b,c);
      if id = ctr then
      begin
         if field = 4 then str(a,get_single_field_entry) ;
         if field = 5 then str(b,get_single_field_entry) ;
         if field = 6 then str(c,get_single_field_entry) ;
      end;
   end;
end;

close(f);

end;

function get_field_menu(x : integer) : string ;
begin
if x = 1 then
   get_field_menu := 'Nama Depan' else
if x = 2 then
   get_field_menu := 'Nama Belakang' else
if x = 3 then
   get_field_menu := 'No Identitas' else
if x = 4 then
   get_field_menu := 'Tanggal Masuk ( tanggal )' else
if x = 5 then
   get_field_menu := 'Tanggal Masuk ( bulan )' else
if x = 6 then
   get_field_menu := 'Tanggal Masuk ( tahun )' else
if x = 7 then
   get_field_menu := 'Alamat' else
if x = 8 then
   get_field_menu := 'No Telp Pribadi' else
if x = 9 then
   get_field_menu := 'No Telp Ortu' else
if x = 10 then
   get_field_menu := 'No Kamar' else
if x = 11 then
   get_field_menu := 'Status Pembayaran' else
if x = 12 then
   get_field_menu := 'Lama Penyewaan'
else get_field_menu := '' ;
end;



procedure show_main_menu ;
Begin
gotoxy(xs,ys-1);print_blue('Menu Utama ');
gotoxy(xs,ys);writeln('------------------------------');
gotoxy(xs,ys+1);writeln('1. Tambah Data');
gotoxy(xs,ys+2);writeln('2. Ubah Data');
gotoxy(xs,ys+3);writeln('3. Hapus Data');
gotoxy(xs,ys+4);writeln('4. Cari / Tampilkan Data');
gotoxy(xs,ys+5);writeln('5. Tambah / Kurangi  Pengguna');
gotoxy(xs,ys+6);writeln('6. Exit ');
gotoxy(xs,ys+7);writeln('------------------------------');
end;

procedure show_insert_menu ;
begin
gotoxy(xs,ys-1);print_blue('Opsi Penambahan Data          ');
gotoxy(xs,ys);writeln('------------------------------');
gotoxy(xs,ys+1);writeln('1. Tambah data anak Kos');
gotoxy(xs,ys+2);writeln('2. Tambah jumlah kamar');
gotoxy(xs,ys+3);writeln('3. Kembali ke menu utama');
gotoxy(xs,ys+4);writeln('------------------------------');
end;

procedure show_alter_menu ;
begin
gotoxy(xs,ys-1);print_blue('Opsi Perubahan Data ');
gotoxy(xs,ys);writeln('------------------------------');
gotoxy(xs,ys+1);writeln('1. Ubah Status Pembayaran ');
gotoxy(xs,ys+2);writeln('2. Ubah Data Penghuni ');
gotoxy(xs,ys+3);writeln('3. Mengubah Kamar Penghuni ');
gotoxy(xs,ys+4);writeln('4. kembali ke menu utama ');
gotoxy(xs,ys+5);writeln('-----------------------------');
end;

procedure show_remove_menu;
begin
gotoxy(xs,ys-1);print_blue('Opsi Penghapusan Data ');
gotoxy(xs,ys);writeln('-----------------------------');
gotoxy(xs,ys+1);writeln('1. Hapus data penghuni ');
gotoxy(xs,ys+2);writeln('2. Kembali ke menu utama ');
gotoxy(xs,ys+3);writeln('-----------------------------');
end;

procedure show_search_menu ;
begin
gotoxy(xs,ys-1);print_blue('Opsi Penampilan dan Pencarian Data ');
gotoxy(xs,ys);writeln('-----------------------------------------------------');
gotoxy(xs,ys+1);writeln('1. Tampilkan data seluruh penghuni ke layar ');
gotoxy(xs,ys+2);writeln('2. Cetak data seluruh penghuni ke dalam file text');
gotoxy(xs,ys+3);writeln('3. Tampilkan seluruh kamar yang kosong');
gotoxy(xs,ys+4);writeln('4. Tampilkan seluruh kamar yang terisi');
gotoxy(xs,ys+5);writeln('5. Cari anak berdasarkan potongan nama');
gotoxy(xs,ys+6);writeln('6. Cari anak berdasarkan alamat');
gotoxy(xs,ys+7);writeln('7. Tampilkan data anak yang belum membayar biaya sewa');
gotoxy(xs,ys+8);writeln('8. Tampilkan data anak yang sudah membayar biaya sewa');
gotoxy(xs,ys+9);writeln('9. Kembali ke menu sebelumnya ');
gotoxy(xs,ys+10);writeln('-----------------------------------------------------');
end;

procedure show_user_menu ;
begin
gotoxy(xs,ys-1);writeln('Menu Konfigurasi Pengguna ');
gotoxy(xs,ys);writeln('--------------------------');
gotoxy(xs,ys+1);writeln('1. Tambah Pengguna ');
gotoxy(xs,ys+2);writeln('2. Hapus Pengguna ');
gotoxy(xs,ys+3);writeln('3. Kembali Ke Menu utama ');
gotoxy(xs,ys+4);writeln('--------------------------');
end;






var
LoginName : string ;
LoginPwd  : string ;
try       : integer ;
auth      : boolean ;
valid     : boolean ;
select_main_menu : smallint ;
main_choice : string;
choice : integer ;
dumy : string ;
anak : user ;
a,i,j,n : integer ;
dibayar : string ;
pay : boolean ;
room: integer ;
x,y,z : integer ;
file_read : string;
fglob : text ;
query : string;
validate : integer;
loop : integer ;
p,q : string;
ctr : integer ;
ch : char ;
px,py : integer ;
dumy1,dumy2 : string;
f1 : text ;
const month : array [1..12] of integer = (31,28,31,30,31,30,31,31,30,31,30,31) ;
begin
clrscr ;
textcolor (white) ;
try := 1 ;
auth := false ;
while ( try <= 4 ) do
begin
        if ( try > 1 ) then
        begin
           gotoxy(10,2);print_red('User tidak dikenal atau password yang anda masukan salah !!');

           gotoxy(10,12);writeln('---------------------------------------------------');
           gotoxy(10,13);writeln('Peringatan : Anda mempunyai kesempatan ',5-try,' lagi');
           gotoxy(10,14);writeln('---------------------------------------------------');
           writeln;
        end;
        gotoxy(10,5);print_blue('Halaman Login ');
        gotoxy(10,6);writeln('--------------------------');
        gotoxy(10,7);writeln('Username : ');
        gotoxy(10,8);readln(LoginName);
        gotoxy(10,9);writeln('Password : ');

        textcolor(black);
        z:=0;
        gotoxy(10,10);
        repeat
        inc(z);
        ch:= readkey;
        if (ch<> #10) and (ch <> #13)  then
        Loginpwd := loginpwd + ch;
        gotoxy(9+z,10);
        textcolor(white);
        write('*');
        textcolor(black);
        until ( ch = #10) or (ch=#13);
        textcolor(white);
        try := try + 1 ;
        clrscr;
        if (Auth_user(LoginNAme,LoginPWd)>0) then
        begin
              auth := true ;
              break ;
        end;
        loginpwd := '';
end;
if (not auth) then
  begin
     gotoxy(10,4);  writeln('----------------------------------');
     gotoxy(10,5);print_red('Maaf, anda tak mempunyai hak akses');
     gotoxy(10,6);  writeln('----------------------------------');

     gotoxy(10,10);print_blue('tekan sembarang tombol untuk keluar ');
     readkey;

     halt;
  end else
begin
        while(select_main_menu <> 6 ) do
        begin
        clrscr;
        gotoxy(1,1);
        textbackground(white);
        textcolor(blue);
        writeln('Selamat Datang ',get_user_from_id(auth_user(loginname,loginpwd)));
        textbackground(black);
        textcolor(white);
        show_main_menu;
        gotoxy(xs,ys+8);write('Masukan Menu Pilihan anda    : ');
        gotoxy(xs+32,ys+8);readln(main_choice);
        select_main_menu := validate_choice(main_choice,6) ;
        while ( select_main_menu < 0 ) do
        begin
           clrscr;
           textbackground(red);
           textcolor (white);
           gotoxy(xs,ys-3);print_red('Maaf, menu yang anda pilih tak dapat ditemukan!!');
           textbackground(black);
           show_main_menu;
           gotoxy(xs,ys+8);write('Masukan Menu Pilihan anda    : ');
           gotoxy(xs+32,ys+8);readln(main_choice);
           select_main_menu := validate_choice(main_choice,6) ;
        end;
        { begin main choice }

        if (select_main_menu = 1 ) then
        begin
           clrscr;
           show_insert_menu ;
           gotoxy(xs,ys+5);writeln('Masukan pilihan anda :');
           gotoxy(xs+23,ys+5);readln(main_choice);
           choice := validate_choice(main_choice,6);
           while ( choice<0 ) do
           begin
              clrscr;
              gotoxy(xs,ys-3);print_red('Maaf, menu yang anda pilih tak dapat ditemukan !!');
              show_insert_menu;
              gotoxy(xs,ys+5);writeln('Masukan pilihan anda :');
              gotoxy(xs+23,ys+5);readln(main_choice);
              choice := validate_choice(main_choice,3) ;
           end;
           if (choice = 1) then
           begin
              clrscr ;
              if (sum_avaible_room>0) then
              begin
              gotoxy(xs,ys-1);print_blue('Opsi Pemasukan Penghuni Baru');
              gotoxy(xs,ys);     writeln('----------------------------');
              n:=get_total_room ;
              loop := 0;
              py:=ys+3;
              gotoxy(xs,py);write('Kamar yang kosong : '); for i:=1 to n do if(check_avaible_room(i)) then
                 begin
                     inc(loop);
                     write(i,' ');
                     if loop > 10 then begin writeln;  gotoxy(xs,wherey+1); loop:=0; end;

                 end;
                 py:=wherey+2;
              gotoxy(xs,py);writeln('--------------------- FORM INPUT DATA ------------------------');
              gotoxy(xs+2,py+1);print_blue('Masukan tanda strip ( - ) jika memang data tidak diketahui');
              gotoxy(xs,py+2);writeln('--------------------------------------------------------------');

              gotoxy(xs+2,py+4);write('Nama Depan : ');
              readln(anak.first_name);

                 while (isblank(anak.first_name)) do
                    begin
                       dcl(xs,py+4);
                       gotoxy(xs+2,py+4);print_red('input tidak boleh kosong !! ');
                       readkey;
                       dcl(xs,py+4);
                       gotoxy(xs+2,py+4);write('Nama Depan : ');
                       readln(anak.first_name);
                    end;

              gotoxy(xs+2,py+6);write('Nama Belakang : ');readln(anak.last_name);
                   while (isblank(anak.last_name)) do
                   begin
                      dcl(xs,py+6);
                      gotoxy(xs+2,py+6);print_red('input tidak boleh kosong !! ');
                      readkey ;
                      dcl(xs,py+6);
                      gotoxy(xs+2,py+6);write('Nama Belakang : ');
                      readln(anak.last_name);
                   end;

              gotoxy(xs+2,py+8);write('NO Identitas : ');readln(anak.no_identitas);
              while (isblank(anak.no_identitas)) do
               begin
                  dcl(xs+2,py+8);
                  gotoxy(xs+2,py+8);print_red('input tidak boleh kosong !! ');
                  readkey;
                  dcl(xs+2,py+8);
                  gotoxy(xs+2,py+8);write('NO Identitas : ');
                  readln(anak.no_identitas);
               end;

              gotoxy(xs+2,py+10);writeln('Tanggal Masuk ');

                gotoxy(xs+5,py+12);write('-  Tahun : ');
                readln(dumy);
                anak.datein.thn := isnumber(dumy);
                while (anak.datein.thn < 0 ) do
                begin
                   gotoxy(xs+5+11,py+12);print_red('input hanya boleh berupa angka !! ');
                   readkey;
                   dcl(xs,py+12);
                   gotoxy(xs+5,py+12);write('-  Tahun : ');
                   readln(dumy);
                   anak.datein.thn := isnumber(dumy);
                end;

                gotoxy(xs+5,py+13);write('-  Bulan [1-12] : ');
                readln(dumy);
                anak.datein.bln := validate_choice(dumy,12);
                while (anak.datein.bln < 0 ) do
                begin
                   gotoxy(xs+5+18,py+13);print_red('input hanya boleh berupa angka 1-12 !! ');
                   readkey;
                   dcl(xs+5,py+13);
                   gotoxy(xs+5,py+13);write('-  Bulan [1-12] : ');
                   readln(dumy);
                   anak.datein.bln := isnumber(dumy);
                   anak.datein.bln := validate_choice(dumy,12);
                end;

                if anak.datein.bln = 2 then
                begin
                   if is_leapyear(anak.datein.thn) then z:= 29 else z:=28 ;
                end else z:= month[anak.datein.bln]   ;

                   gotoxy(xs+5,py+14);write('-  Tanggal [1-',z,'] : ');
                   readln(dumy);
                   anak.datein.tgl := validate_choice(dumy,z);
                   while (anak.datein.tgl < 0 ) do
                   begin
                    gotoxy(xs+5+19,py+14);
                    textbackground(red);
                    writeln('input hanya boleh berupa angka [1-',z,'] !! ');
                    textbackground(black);
                    readkey;
                    dcl(xs+5,py+14);

                    gotoxy(xs+5,py+14);write('-  Tanggal [1-',z,'] : ');
                    readln(dumy);

                    anak.datein.tgl := isnumber(dumy);
                    anak.datein.tgl := validate_choice(dumy,z);
                   end;
              py:=wherey+1; { biat gak pusing ! }
              gotoxy(xs+2,py);write('Alamat Asal : ');
              readln(anak.alamat);
              while (isblank(anak.alamat)) do
              begin

                 gotoxy(xs+2+14,py);print_red('input tidak boleh kosong !! ');
                 readkey;
                 dcl(xs,py);
                 gotoxy(xs+2,py);write('Alamat Asal : ');
                 readln(anak.alamat);
              end;

              gotoxy(xs+2,py+2);write('No Telp Pribadi / HP : ');
              readln(anak.telp);
              while (isblank(anak.telp)) do
              begin
                gotoxy(xs+2+24,py+2);print_red('input tidak boleh kosong !! ');
                readkey;
                dcl(xs,py+2);
                gotoxy(xs+2,py+2);write('No Telp Pribadi / HP : ');
                readln(anak.telp);
              end;

              gotoxy(xs+2,py+4);write('No Telp Orang Tua : ');
              readln(anak.telp_ot);
              while (isblank(anak.telp_ot)) do
                 begin
                     gotoxy(xs+2+21,py+4);print_red('input tidak boleh kosong !! ');
                     readkey;
                     dcl(xs,py+4);
                     gotoxy(xs+2,py+4);write('No Telp Orang Tua : ');
                     readln(anak.telp_ot);
                 end;

              gotoxy(xs+2,py+6);write('Apakah anak sudah membayar ? [y/n] : ');
              readln(dibayar);
                while (isblank(dibayar) or not is_yesornot(dibayar)) do
                 begin
                    dcl(xs+2,py+6);
                    gotoxy(xs+2,py+6);print_red('input hanya boleh huruf "y" atau "n" !! ');
                    readkey;
                    dcl(xs+2,py+6);
                    gotoxy(xs+2,py+6);write('Apakah anak sudah membayar ? [y/n] : ');
              readln(dibayar);
                 end;

              if (dibayar='y') or (dibayar='Y') then pay:=true else pay:=false;

              gotoxy(xs+2,py+8);write('Dikamar berapa anak akan ditempatkan : ');readln(dumy);

               room := isnumber(dumy);
               while (room < 0) do
               begin
                  dcl(xs,py+8);
                  gotoxy(xs+2,py+8);print_red('input hanya boleh berupa angka !! ');
                  readkey;
                  dcl(xs,py+8);
                  gotoxy(xs+2,py+8);write('Dikamar berapa anak akan ditempatkan : ');readln(dumy);
                  room := isnumber(dumy);
               end;

              if (not check_avaible_room(room)) then
              repeat
                 loop:=0;
                 gotoxy(xs+2,py+11);write('Kamar yang dapat dihuni : '); for i:=1 to n do if(check_avaible_room(i)) then
                 begin
                     inc(loop);
                     write(i,' ');
                     if loop > 10 then begin gotoxy(xs,wherey+1);loop:=0;writeln;  end;
                 end;
                  dcl(xs,py+10);
                  gotoxy(xs+2,py+10);
                  textbackground(red);
                  gotoxy(xs+2,py+10);writeln('Maaf, kamar ',room,' tidak ada atau sudah terisi ! ');
                  textbackground(black);
                  readkey;
                  dcl(xs,py+11);
                  dcl(xs,py+12);
                  dcl(xs,py+13);
                  dcl(xs,py+14);
                  dcl(xs,py+15);
                  dcl(xs,py+8);
                  gotoxy(xs+2,py+8);write('Dikamar berapa anak akan ditempatkan : ');readln(dumy);
                  room := isnumber(dumy);
                  room := isnumber(dumy);


             while (room < 0) do
               begin
                  dcl(xs,py+8);
                  gotoxy(xs+2,py+8);print_red('input hanya boleh berupa angka !! ');
                  readkey;
                  dcl(xs,py+8);
                   gotoxy(xs+2,py+8);write('Dikamar berapa anak akan ditempatkan : ');readln(dumy);
                  room := isnumber(dumy);
               end;


              until (check_avaible_room(room));
              py:= wherey+1;

              gotoxy(xs+2,py);write('Berapa lama anak akan menyewa ( bulan ) : ');
              readln(dumy);
               anak.lama := isnumber(dumy);
               while anak.lama < 0 do
               begin
                 gotoxy(xs+2+42,py);print_red('input hanya boleh berupa angka ! ');
                 readkey;
                 dcl(xs+2,py);
                 gotoxy(xs+2,py);write('Berapa lama anak akan menyewa ( bulan ) : ');

                 anak.lama := isnumber(dumy);
               end;
               gotoxy(xs,py+2);writeln('--------------------------------------------------------------');

               gotoxy(xs,py+3);write('Yakin akan memasukan data diatas [y/n] : ');
               readln(dumy);
               while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,py+3);
                    gotoxy(xs,py+3);print_red('input hanya boleh huruf "y" atau "n" !! ');
                    readkey;
                    dcl(xs,py+3);
                     gotoxy(xs,py+3);write('Yakin akan memasukan data diatas [y/n] : ');
               readln(dumy);

                 end;
              if (dumy='y') or (dumy='Y') then
              begin
                add_data_anak(anak.first_name,anak.last_name,anak.no_identitas,anak.datein,
                anak.alamat,anak.telp,anak.telp_ot,pay,room,anak.lama) ;
                gotoxy(xs,py+5);
                pgreen(2000,'Data sudah dimasukan, tekan sembarang tombol untuk kembali ');
                readkey;

              end else
              begin
                gotoxy(xs,py+5);pgreen(2000,'Operasi dibatalkan, tekan sembarang tombol untuk kembali');
                readkey;
              end;

              end { end dari if check sum avaible room }
              else
                begin
                gotoxy(xs+5,ys+9);print_red('Maaf, tidak ada lagi kamar yang kosong !!');
                gotoxy(xs,ys+12);writeln('Tekan sembarang tombol untuk kembali ke menu utama');
                readkey;
                end;
          end else
           if (choice = 2) then
           begin
              clrscr;
              gotoxy(xs,ys-1);print_blue('Opsi Penambahan Jumlah Kamar');
              gotoxy(xs,ys);     writeln('-----------------------------');
              gotoxy(xs,ys+1);   Writeln('Jumlah kamar saat ini    : ',get_total_room);
              gotoxy(xs,ys+2)   ;writeln('Jumlah kamar yang terisi : ',get_total_room-sum_avaible_room);
              gotoxy(xs,ys+3)   ;writeln('Jumkah kamar yang kosong : ',sum_avaible_room);
              gotoxy(xs,ys+4);   writeln('-----------------------------');
              gotoxy(xs,ys+5);write('Masukan jumlah kamar baru atau 0 untuk batal : ');
              gotoxy(xs+47,ys+5);readln(dumy);
              n := isnumber(dumy) ;
              while n < 0 do
              begin
                  gotoxy(xs,ys+6);
                  textbackground(red);
                  writeln('Masukan bilangan bulat dari 1 sampai ',TOTAL_ROOM-get_total_room);
                  textbackground(black);
                  readkey;
                  dcl(xs,ys+6);
                  dcl(xs+47,ys+5);
                  gotoxy(xs+47,ys+5);readln(dumy);
                  n := isnumber(dumy) ;
              end;

              add_room(n);
              gotoxy(xs,ys+7+n);print_blue('Selesai, tekan sembarang tombol untuk melanjutkan ');
              readkey;
           end;


       end else if ( select_main_menu = 2 ) then
       begin
         choice := 0;
         while choice <> 4 do
         begin
         clrscr;
         show_alter_menu;
         dcl(xs,ys+6);
         gotoxy(xs,ys+6);write('Masukan Pilihan Anda : ');readln(dumy);
         choice := validate_choice(dumy,4);
         while (choice<0) do
           begin
              dcl(xs,ys+6);
              print_red('Pilihan Salah ! Silahkan Ulangi ');
              readkey;
              dcl(xs,ys+6);
              gotoxy(xs,ys+6);write('Masukan Pilihan Anda : ');readln(dumy);
              choice := validate_choice(dumy,4);
           end;

         if (choice = 1) then
         begin
            clrscr;
            gotoxy(xs,ys);print_blue('Mengubah status pembayaran penghuni');
            gotoxy(xs,ys+1);writeln('-----------------------------------');
            gotoxy(xs,ys+3);write('Silahkan masukan nama penghuni : ');readln(query);
            fetch := 0;
            loop := 0;
            gotoxy(xs,ys+4);writeln('---------------------------------------------------------------');
            z:=0;
            repeat
               inc(loop);
               x:= get_id_from_query(query);
               if (x>0) then
               begin
                  inc(z);
                  gotoxy(xs,ys+5+z);write('penghuni dengan NO-ID : ',x,' ',get_name_from_id(x));
                  if get_pay_status_from_id(x) then writeln(' Sudah Membayar')
                  else writeln(' Belum Membayar');
               end;
            until x<0 ;
            fetch := 0;
            if (loop=1) then
            begin
              textbackground(red);
              gotoxy(xs,ys+z+6);writeln('Tidak ditemukan penghuni dengan nama mengandung kata ',query);
              textbackground(black);
            end else
            begin
               textbackground(blue);
               gotoxy(xs,ys+z+7);writeln('Ditemukan sebanyak ',loop-1,' data ');
               textbackground(black);
            end;
            gotoxy(xs,ys+z+8);writeln('---------------------------------------------------------------');
            gotoxy(xs,ys+z+9);write('Masukan NO-ID penghuni yang ingin anda ubah atau 0 untuk kembali : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,ys+z+9);
               gotoxy(xs,ys+z+9);print_red('ID tidak ditemukan atau input salah !! ');
               readkey;
               dcl(xs,ys+z+9);
               gotoxy(xs,ys+z+9);write('Masukan NO-ID penghuni yang ingin anda ubah atau 0 untuk kembali : ');
               readln(dumy);
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y<>0 then
            begin
            clrscr;
            gotoxy(xs,ys-1);print_blue('Informasi Penghuni ');
            show_data_anak(y,y,0);
            z:=wherey+1;
            gotoxy(xs,z);write('Ubah status pembayaran dari ',get_name_from_id(y),' ? [y/n] ');readln(dumy);
            while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,z);
                    gotoxy(xs,z);print_red('input hanya boleh huruf "y" atau "n" !! ');
                    readkey;
                    dcl(xs,z);
                    gotoxy(xs,z);write('Ubah status pembayaran dari ',get_name_from_id(y),' ? [y/n] ');
                    readln(dumy);
                 end;
            if (dumy='y') or (dumy='Y') then
            begin
             change_pay_stat(y);
             gotoxy(xs,z+1);writeln;
             gotoxy(xs,z+2);write('Status penghuni dengan NO-ID : ',y,' ',get_name_from_id(y),' kini ');
             if get_pay_status_from_id(y) then pgreen(0,'sudah membayar')
                  else pred(0,'belum Membayar');
             gotoxy(xs,z+4);
             pgreen(2000,'Selesai, tekan sembarang tombol untuk kembali');
             readkey;
            end else begin gotoxy(xs,z+2);print_red('Operasi Dibatalkan, tekan sembarang tombol untuk kembali');readkey; end;
            end;

         end else
         if (choice = 2) then
         begin
            clrscr;
            gotoxy(xs,ys-1);print_blue('Mengubah Data Penghuni');
            gotoxy(xs,ys);writeln('----------------------');
            gotoxy(xs,ys+1);write('Silahkan masukan nama penghuni : ');readln(query);
            fetch := 0;
            loop:=0;
            gotoxy(xs,ys+2);writeln('---------------------------------------------------------------');
            repeat
               inc(loop);
               x:= get_id_from_query(query);
               if (x>0) then
               begin
                  gotoxy(xs+2,wherey+1);writeln(get_name_from_id(x),' adalah penghuni dengan NO-ID : ',x);
               end;
            until x<0 ;
            fetch := 0;
            py:=wherey;
             if (loop=1) then
            begin
              textbackground(red);

              gotoxy(xs,py+1);writeln('Tidak ditemukan penghuni dengan nama mengandung kata ',query);
              textbackground(black);
            end else
            begin
               textbackground(blue);
               gotoxy(xs,py+1);writeln('Ditemukan sebanyak ',loop-1,' data ');
               textbackground(black);
            end;
            gotoxy(xs,py+2);writeln('---------------------------------------------------------------');
            gotoxy(xs,py+3);write('Masukan NO-ID penghuni yang akan diubah atau 0 untuk batal : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,py+3);
               gotoxy(xs,py+3);print_red('ID tidak ditemukan atau input salah !! ');
               readkey;
               dcl(xs,py+3);
               readln(dumy);
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y=0 then begin
            gotoxy(xs,py+3);print_red('Operasi dibatalkan ! tekan sembarang tombol untuk kembali ');
            readkey;
            continue ;
            end;
            clrscr;
            gotoxy(xs,ys-1);print_blue('Informasi Penghuni ');
            gotoxy(xs,ys);show_data_anak(y,y,1);
            py:=wherey;
            gotoxy(xs,py);write('Masukan kode field yang ingin anda ubah : ');readln(dumy);
            z := validate_choice(dumy,12) ;
            while ( z<0 ) do
            begin
               dcl(xs,py);
               gotoxy(xs,py);print_red('Code field tidak ditemukan atau input salah !!');
               readkey;
               dcl(xs,py);
               gotoxy(xs,py);write('Masukan kode field yang ingin anda ubah : ');
               readln(dumy);
               z:= validate_choice(dumy,12);
            end;
            clrscr ;
            gotoxy(xs,ys-1);print_blue('Informasi field yang akan diubah ');
            gotoxy(xs,ys);writeln('----------------------------------------------------');
            gotoxy(xs,ys+1);writeln('Field yang akan diubah : ',get_field_menu(z));
            gotoxy(xs,ys+2);writeln('Isi sekarang adalah    : ',get_single_field_entry(z,y));
            gotoxy(xs,ys+3);writeln('----------------------------------------------------');

            if z = 10 then
            begin
              if sum_avaible_room > 0 then
                begin
                  gotoxy(xs,ys+5);writeln('Ada ',sum_avaible_room, ' yang kosong');
                  gotoxy(xs,ys+5);write('Yaitu kamar : ');
                  for i:=1 to get_total_room do
                    begin
                      if check_avaible_room(i) then begin
                      gotoxy(wherex,ys+5);write(i,' ');
                      end;
                    end;
                  py:=wherey;
                  gotoxy(xs,py+1);writeln;

                  gotoxy(xs,py+2);writeln('----------------------------------------------------');
                end else
                begin
                  gotoxy(xs,ys+4);
                  Print_red('Semua Kamar sudah terisi !!!');
                  gotoxy(xs,ys+5);pgreen(2000,'tekan sembarang tombol untuk kembali ');
                  readkey;
                  continue;
                end;
            end;
            py:=wherey;
            gotoxy(xs,py);write('Masukan ',get_field_menu(z),' yang baru : ');
            readln(query);

            if z = 10 then
            begin
               a:= validate_choice(query,get_total_room);
               while ( a < 0 ) do
               begin
                  dcl(xs,py);
                  gotoxy(xs,py);
                  write('input harus berupa angka !! silahkan ulangin : ');
                  readln(query);
                  a:= validate_choice(query,get_total_room);
               end;
               while not(check_avaible_room(a)) do
               begin
                  dcl(xs,py);
                  gotoxy(xs,py);
                  write('Maaf, kamar sudah terisi ! Ulangi : ');readln(query);
                  a:= validate_choice(query,get_total_room);
                  while ( a < 0 ) do
                  begin

                     dcl(xs,py);
                     gotoxy(xs,py);write('input harus berupa angka !! silahkan ulangi : ');
                     readln(query);
                     a:= validate_choice(query,get_total_room);
                  end;
               end;
            end;
            py:=wherey ;
            gotoxy(xs,py);write('Yakin akan mengubah data ',get_name_from_id(y),' ? [y/n] ');readln(dumy);
            while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,py);
                    gotoxy(xs,py);print_red('Input hanya boleh berupa karakter "n" atau "y" !! ');
                    readkey;
                    dcl(xs,py);
                    gotoxy(xs,py);write('input harus berupa angka !! silahkan ulangi : ');
                     readln(query);
                 end;
            if (dumy='y') or (dumy='Y') then
            begin
            { perlakuan khusus untuk no kamar dan status pembayaran }
            alter_field_entry(z,y,query);
            clrscr;
            gotoxy(xs,ys);  print_blue('Operasi Berhasil Dilakukan ');
            gotoxy(xs,ys+1);   writeln('--------------------------------------------------------');
            gotoxy(xs,ys+2);     write('data yang baru menjadi : ');
            gotoxy(xs+25,ys+2);show_data_anak(y,y,1);
            py:=wherey;
            gotoxy(xs,py+1);pgreen(2000,'Selesai, tekan sembarang tombol untuk kembali');
            readkey;
            end else
            begin
               dcl(xs,py);
               gotoxy(xs,py);print_red('Operasi Dibatalkan !!');
               readkey;
            end;


         end else
         if (choice = 3) then
         begin
            clrscr;
            gotoxy(xs,ys-1);print_blue('Memindahkan Penghuni ');
            gotoxy(xs,ys);writeln('---------------------');
            gotoxy(xs,ys+1);write('Silahkan masukan nama penghuni : ');readln(query);
            fetch := 0;
            loop:=0;
            gotoxy(xs,ys+3);writeln('---------------------------------------------------------------');
            py := wherey;
            repeat
               inc(loop);
               x:= get_id_from_query(query);
               if (x>0) then
               begin
                  gotoxy(xs+2,wherey+1);writeln(get_name_from_id(x),' adalah penghuni dengan NO-ID : ',x);
               end;
            until x<0 ;
            fetch := 0;
            py:=wherey+1 ;
             if (loop=1) then
            begin
              textbackground(red);
              gotoxy(xs,py);writeln('Tidak ditemukan penghuni dengan nama mengandung kata ',query);
              textbackground(black);
            end else
            begin
               textbackground(blue);
               gotoxy(xs,py);writeln('Ditemukan sebanyak ',loop-1,' data ');
               textbackground(black);
            end;
            gotoxy(xs,py+1);writeln('---------------------------------------------------------------');
            gotoxy(xs,py+2);write('Masukan NO-ID penghuni yang akan diubah atau 0 untuk batal : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,py+2);
               gotoxy(xs,py+2);
               print_red('Maaf, input salah atau NO ID Tidak ditemukan !! ');
               readkey;
               dcl(xs,py+2);
               gotoxy(xs,py+2);write('Masukan NO-ID penghuni yang akan diubah atau 0 untuk batal ');
               readln(dumy);
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y=0 then
            begin
               dcl(xs,py+2);
               gotoxy(xs,py+2);
               print_red('Operasi dibatalkan ! tekan sembarang tombol untuk kembali ');
               readkey;
               continue ;
            end;
             clrscr;
             gotoxy(xs,ys-1);print_blue('Informasi Penghuni ');
             gotoxy(xs,ys);show_data_anak(y,y,1);
             py:= wherey ;

             if sum_avaible_room > 0 then
             begin

                gotoxy(xs,py+1);writeln('Ada ',sum_avaible_room, ' yang kosong');
                gotoxy(xs,py+2);writeln('Yaitu kamar ');
                gotoxy(xs+12,py+2);
                for i:=1 to get_total_room do
                 begin
                   if check_avaible_room(i) then  write(i,' ');
                 end;

               gotoxy(xs,py+3);writeln('----------------------------------------------------');
            end else
            begin
               gotoxy(xs,py+1);print_red('Maaf. Semua Kamar Sudah Terisi Penuh !!');
               gotoxy(xs,py+2);pgreen(2000,'Tekan Sembarang Tombol Untuk Melanjutkan ');
               readkey;
               continue;
            end;
            gotoxy(xs,py+4);write('Masukan No Kamar yang baru yang baru : ');
            readln(query);

            begin
               a:= validate_choice(query,get_total_room);
               while ( a < 0 ) do
               begin
                  dcl(xs,py+4);
                  print_red('input harus berupa angka, silahkan ulangi ! ');
                  readkey;
                  dcl(xs,py+4);
                  gotoxy(xs,py+4);write('Masukan No Kamar yang baru yang baru : ');
                  readln(query);
                  a:= validate_choice(query,get_total_room);
               end;
               while not(check_avaible_room(a)) do
               begin
                  dcl(xs,py+4);
                  print_red('Maaf, kamar sudah terisi ! Masukan no kamar yang lain ');
                  readkey;
                  dcl(xs,py+4);
                  gotoxy(xs,py+4);write('Masukan No Kamar yang baru yang baru : ');
                  readln(query);
                  a:= validate_choice(query,get_total_room);
                  while ( a < 0 ) do
                  begin
                     dcl(xs,py+4);
                     print_red('input harus berupa angka, silahkan ulangi ! ');
                     readkey;
                     dcl(xs,py+4);
                     gotoxy(xs,py+4);write('Masukan No Kamar yang baru yang baru : ');
                     readln(query);
                     a:= validate_choice(query,get_total_room);
                  end;
               end;

            end;
            py := wherey;
            gotoxy(xs,py+1);write('Yakin akan memindahkan ',get_name_from_id(y),' ke kamar ',query,' ? [y/n] ');readln(dumy);
            while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,py+1);
                    gotoxy(xs,py+1);print_red('Input hanya boleh berupa karakter "n" atau "y" !! ');
                    readkey;
                    dcl(xs,py+1);
                    gotoxy(xs,py+1);write('Yakin akan memindahkan ',get_name_from_id(y),' ke kamar ',query,' ? [y/n] ');readln(dumy);
                 end;
            if (dumy='y') or (dumy='Y') then
            begin

            alter_field_entry(10,y,query);
            clrscr;
            gotoxy(xs,ys-1);print_blue('Operasi Berhasil Dilakukan');
            gotoxy(xs+26,ys-1);writeln(' - data yang baru menjadi ');
            show_data_anak(y,y,1);
            end else begin dcl(xs,py+1);gotoxy(xs,py+1);writeln('Operasi Dibatalkan !!');readkey;continue; end;
            py := wherey ;
            gotoxy(xs,py);pgreen(2000,'Selesai, tekan sembarang tombol untuk kembali ');
            readkey;
         end;
         end;
       end { end of select_main_menu = 2} else
       if ( select_main_menu = 3 ) then
       begin
         choice:=0;
         while (choice <>2) do
         begin
         clrscr;
         show_remove_menu;
         py:=wherey ;
         gotoxy(xs,py);write('Masukan pilihan anda : ');readln(dumy);
         choice := validate_choice(dumy,2);
         while ( choice < 0 ) do
         begin
            dcl(xs,py);
            gotoxy(xs,py);print_red('Maaf, Pilihan Salah ! Silahkan Ulangi ');
            readkey;
            dcl(xs,py);
            write('Masukan pilihan anda : ');readln(dumy);
            choice := validate_choice(dumy,2);
         end;


         if choice = 1 then
         begin
            clrscr;
            clrscr;
            gotoxy(xs,ys-1);print_blue('Menghapus Data Penghuni ');
            gotoxy(xs,ys);writeln('---------------------');
            gotoxy(xs,ys+1);write('Silahkan masukan nama penghuni : ');readln(query);
            fetch := 0;
            loop:=0;
            gotoxy(xs,ys+3);writeln('---------------------------------------------------------------');
            py := wherey;
            repeat
               inc(loop);
               x:= get_id_from_query(query);
               if (x>0) then
               begin
                  gotoxy(xs+2,wherey+1);writeln(get_name_from_id(x),' adalah penghuni dengan NO-ID : ',x);
               end;
            until x<0 ;
            fetch := 0;
            py:=wherey+1 ;
             if (loop=1) then
            begin
              textbackground(red);
              gotoxy(xs,py);writeln('Tidak ditemukan penghuni dengan nama mengandung kata ',query);
              textbackground(black);
            end else
            begin
               textbackground(blue);
               gotoxy(xs,py);writeln('Ditemukan sebanyak ',loop-1,' data ');
               textbackground(black);
            end;
            gotoxy(xs,py+1);writeln('---------------------------------------------------------------');
            gotoxy(xs,py+2);write('Masukan NO-ID penghuni yang akan diubah atau 0 untuk batal : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,py+2);
               gotoxy(xs,py+2);
               print_red('Maaf, input salah atau NO ID Tidak ditemukan !! ');
               readkey;
               dcl(xs,py+2);
               gotoxy(xs,py+2);write('Masukan NO-ID penghuni yang akan diubah atau 0 untuk batal ');
               readln(dumy);
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y=0 then
            begin
               dcl(xs,py+2);
               gotoxy(xs,py+2);
               print_red('Operasi dibatalkan ! tekan sembarang tombol untuk kembali ');
               readkey;
               continue ;
            end;
            clrscr;
            gotoxy(xs,ys-1);print_blue('Informasi penghuni ');
            gotoxy(xs,ys);
            show_data_anak(y,y,0);
            py:=wherey;
            gotoxy(xs,py+4);print_red('PERINGATAN : Data yang sudah dihapus tak dapat dikembalikan !!');
            gotoxy(xs,py);write('Yakin akan menghapus ?, masukan pilihan [y/n] : ');readln(dumy);

            while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,py);
                    gotoxy(xs,py);print_red('Input hanya boleh berupa karakter "n" atau "y" !! ');
                    readkey;
                    dcl(xs,py);
                    gotoxy(xs,py);write('Yakin akan menghapus ?, masukan pilihan [y/n] : ');readln(dumy);
                 end;


            if (dumy='y') or (dumy='Y') then
            begin
              change_room_stat(get_room_from_id(y));
              delete_data_anak(y);

              dcl(xs,py+4);
              dcl(xs,py);
              gotoxy(xs,py+1);
              pgreen(2000,'Data Sudah Dihapus, tekan sembarang tombol untuk kembali ');
              readkey;
            end  else
            begin
              dcl(xs,py+4);
              dcl(xs,py);
              gotoxy(xs,py+1);
              pgreen(2000,'Operasi dibatalkan, tekan sembarang tombol untuk kembali ');
              readkey;
            end;
         end;
       end;

       end else
       if (select_main_menu = 4 ) then
       begin
          choice:=0;
          while ( choice <> 9 ) do
          begin

          clrscr;

          show_search_menu ;
          py := wherey;
          gotoxy(xs,py);write('Silahkan Masukan Pilihan Anda : ');readln(dumy);
          choice := validate_choice(dumy,9);
          while ( choice < 0 ) do
          begin
             dcl(xs,py);
             print_red('Maaf, Menu yang anda masukan salah !! ');
             readkey;
             dcl(xs,py);
             gotoxy(xs,py);write('Silahkan Masukan Pilihan Anda : ');readln(dumy);
             choice := validate_choice(dumy,9);
             choice := validate_choice(dumy,9);
          end;

          if (choice = 1) then
          begin
             clrscr;
             gotoxy(xs,ys);print_blue('Menampilkan data seluruh penghuni ke layar ');
             gotoxy(xs,ys+1);writeln('-------------------------------------------');
             gotoxy(xs,ys+2);writeln('Saat ini ada total : ',get_total_occupant,' penghuni');
             gotoxy(xs,ys+4);write(' ---> Tampilkan mulai dari penghuni ke (i) : ');readln(dumy1);
             gotoxy(xs,ys+5);write(' ---> Sampai penghuni ke (j)               : ');readln(dumy2);
             x:=validate_choice(dumy1,get_total_occupant);
             y:=validate_choice(dumy2,get_total_occupant);
             while ( (x<0) or  (y<0)  or ( y<x ) ) do
             begin
                dcl(xs,ys+4);
                dcl(xs,ys+5);
                gotoxy(xs,ys+5);print_red('Input salah ! atau nilai j lebih kecil dari i !! ');
                readkey;
                dcl(xs,ys+5);
                gotoxy(xs,ys+4);write(' ---> Tampilkan mulai dari penghuni ke (i) : ');readln(dumy1);
                gotoxy(xs,ys+5);write(' ---> Sampai penghuni ke (j)               : ');readln(dumy2);
                x:=validate_choice(dumy1,get_total_occupant);
                y:=validate_choice(dumy2,get_total_occupant);
             end;
             clrscr;
             gotoxy(2,2);print_blue('------- Menampilkan Data Anak -------');
             gotoxy(xs,ys);
             show_data_anak(x,y,0);
             py:=wherey ;
             gotoxy(xs,py);pgreen(2000,'Selesai - tekan sembarang tombol untuk kembali ke menu sebelumnya ');
             readkey;
          end;
          if choice=2 then
          begin
             clrscr;
             gotoxy(xs,ys);print_blue('Mencetak data seluruh penghuni ke dalam file text');
             gotoxy(xs,ys+1); writeln('-------------------------------------------------');
             dumy:='';
             while not ((dumy='y') or (dumy='Y')) do
             begin
             gotoxy(xs,ys+2);write('Masukan Nama File dengan ekstensinya : ');readln(file_read);
             gotoxy(xs,ys+3);write('Apakah nama file sudah benar ?, masukan pilihan [y/n] : ');readln(dumy);

             while (isblank(dumy) or not is_yesornot(dumy)) do
                 begin
                    dcl(xs,ys+3);
                    gotoxy(xs,ys+3);print_red('Input hanya boleh berupa karakter "n" atau "y" !! ');
                    readkey;
                    dcl(xs,ys+3);
                    gotoxy(xs,ys+3);write('Apakah nama file sudah benar ?, masukan pilihan [y/n] : ');readln(dumy);
             end;
             end;

             print_to_file(file_read);
             gotoxy(xs,ys+5);writeln('---------------------------------------------------');
             gotoxy(xs,ys+6);pgreen(2000,'selesai, tekan sembarang tombol untuk kembali ');
             readkey;
          end else
          if ( choice = 3 ) then
          begin
             clrscr ;
             gotoxy(xs,ys);print_blue('Menampilkan seluruh kamar yang kosong');
             gotoxy(xs,ys+1);writeln('-------------------------------------');
             gotoxy(xs,ys+3);writeln('Ada ',sum_avaible_room, ' yang kosong');
             gotoxy(xs,ys+4);writeln('Yaitu kamar ');
             gotoxy(xs,ys+5);
             for i:=1 to get_total_room do
             begin
                if check_avaible_room(i) then write(i,' ');
             end;
             py:=wherey+1;
             gotoxy(xs,py);writeln('--------------------------------------------');
             gotoxy(xs,py+1);pgreen(2000,'Selesai, tekan sembarang tombol untuk melanjutkan ');
             readkey;
          end else if choice=4 then
          begin
             clrscr ;
             gotoxy(xs,ys);print_blue('Menampilkan seluruh kamar yang terisi');
             gotoxy(xs,ys+1);writeln('-------------------------------------');
             gotoxy(xs,ys+2);
             for i:=1 to get_total_room do
             begin
                if (not check_avaible_room(i)) then
                begin
                  gotoxy(xs,wherey+1);writeln('Kamar ke-',i,' dihuni oleh ',get_name_from_room(i));
                end;
             end;
             py:= wherey;
             gotoxy(xs,py);writeln('------------------------------------------------');
             gotoxy(xs,py+2);pgreen(2000,'Selesai, tekan sembarang tombol untuk kembali ');
             readkey;
          end else if choice=5 then
          begin
             clrscr;
             gotoxy(xs,ys-1);print_blue('Mencari data penghuni berdasar nama');
             gotoxy(xs,ys);     writeln('-----------------------------------');
            gotoxy(xs,ys+1);write('Silahkan masukan nama penghuni : ');readln(query);
            fetch := 0;
            loop:=0;
            gotoxy(xs,ys+3);writeln('---------------------------------------------------------------');
            py := wherey;
            repeat
               inc(loop);
               x:= get_id_from_query(query);
               if (x>0) then
               begin
                  gotoxy(xs+2,wherey+1);writeln(get_name_from_id(x),' adalah penghuni dengan NO-ID : ',x);
               end;
            until x<0 ;
            fetch := 0;
            py:=wherey+1 ;
             if (loop=1) then
            begin
              textbackground(red);
              gotoxy(xs,py);writeln('Tidak ditemukan penghuni dengan nama mengandung kata ',query);
              textbackground(black);
            end else
            begin
               textbackground(blue);
               gotoxy(xs,py);writeln('Ditemukan sebanyak ',loop-1,' data ');
               textbackground(black);
            end;
            py:=wherey+1;

             gotoxy(xs,py);writeln('----------------------------------------------------------------------');
             gotoxy(xs,py+1);write('Masukan NO-ID yang akan ditampilkan atau 0 untuk batal : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,py+1);
               print_red('Maaf, NO ID tidak ditemukan atau input salah !!!');
               readkey;
               dcl(xs,py+1);
                gotoxy(xs,py+1);write('Masukan NO-ID penghuni yang akan ditampilkan atau 0 untuk batal : ');
               readln(dumy);
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y<>0 then
            begin
            clrscr;
            gotoxy(xs,ys);
            show_data_anak(y,y,0);
            end;
            py:=wherey;
             gotoxy(xs,py);pgreen(2000,'Selesai, Tekan sembarang tombol untuk melanjutkan');
             readkey;
          end else if choice = 6 then
          begin
           clrscr;
             gotoxy(xs,ys);print_blue('Mencari data penghuni berdasar asal');
             gotoxy(xs,ys+1); writeln('-----------------------------------');
             gotoxy(xs,ys+2);   write('Masukan potongan nama daerah penghuni : ');readln(query);
             fetch :=0 ;
             loop := 0;
             gotoxy(xs,ys+3);
             repeat
                inc(loop);
                x := get_id_from_area(query);
                if (x>0) then
                begin
                   writeln;
                   write('Penghuni dengan NO-ID ',x,' ',get_name_from_id(x));
                   writeln(' menempati Kamar ',get_room_from_id(x));
                   writeln('Beralamat di : ',get_single_field_entry(x,7));
                end;
             until (x<0);
             fetch:=0;
             if loop = 1 then
             begin
                textbackground(red);
                dcl(xs,ys+3);
                gotoxy(xs,ys+3);writeln('Maaf ! tidak ditemukan nama penghuni yang mengandung kata : ',query);
                dcl(xs,ys+3);
                textbackground(black);
             end;
             py:=wherey+1;
             gotoxy(xs,py);writeln('----------------------------------------------------------------------');
             gotoxy(xs,py+1);;write('Masukan NO-ID penghuni yang akan ditampilkan atau 0 untuk batal : ');
            readln(dumy);
            y:= isnumber(dumy);
            if y<>0 then validate_choice(dumy,get_total_occupant);
            while (y<0) do
            begin
               dcl(xs,py+1);
               gotoxy(xs,py+1);print_red('Maaf, NO ID tidak ditemukan atau input salah !!');
               readkey;
               dcl(xs,py+1);
               gotoxy(xs,py+1);write('Masukan NO-ID penghuni yang akan ditampilkan atau 0 untuk batal : ');
               y:= isnumber(dumy);
               if y<>0 then validate_choice(dumy,get_total_occupant);
            end;
            if y<>0 then
            begin
            clrscr;
            gotoxy(xs,ys);

            show_data_anak(y,y,0);
            end;
             py:=wherey+1;
             gotoxy(xs,py);pgreen(2000,'Selesai, Tekan sembarang tombol untuk melanjutkan');
             readkey;

          end else if choice = 7 then
          begin
          clrscr;
             gotoxy(xs,ys);print_blue('Menampilkan data anak yang belum membayar biaya sewa');
             gotoxy(xs,ys+1);writeln('-----------------------------------------');
             gotoxy(xs,ys+2);writeln('Tekan sembarang tombol untuk mulai menampilkan ');
             readkey;
             gotoxy(xs,ys+4);
             for i:=1 to get_total_occupant do
             begin
                if not get_pay_status_from_id(i) then
                writeln(get_name_from_id(i),' belum membayar ');
             end;
             py:=wherey+1;
             gotoxy(xs,py);pgreen(2000,'Selesai - tekan sembarang tombol untuk melanjutkan');
             readkey;
          end else if choice = 8 then
          begin
            gotoxy(xs,ys);print_blue('Menampilkan data anak yang sudah membayar biaya sewa');
            gotoxy(xs,ys+1);writeln('----------------------------------------------------');
            gotoxy(xs,ys+2);writeln('Tekan sembarang tombol untuk mulai menampilkan ');
            readkey;
            gotoxy(xs,ys+4);
            for i:=1 to get_total_occupant do
            begin
               if get_pay_status_from_id(i) then
               writeln(get_name_from_id(i),' sudah membayar ');
            end;
            py:=wherey+1;
             gotoxy(xs,py);pgreen(2000,'Selesai - tekan sembarang tombol untuk melanjutkan');
             readkey;
          end;

       end;
       end else
       if (select_main_menu = 5 ) then
       begin
       choice:=0;
       while (choice <> 3) do
         begin
             clrscr;
             if auth_user(Loginname,Loginpwd) <> 1 then
             begin
               gotoxy(xs,ys-1);print_red('Maaf, hanya admnistrator yang berhak mengakses menu ini !!');
               gotoxy(xs,ys);writeln('----------------------------------------------------------');
               gotoxy(xs,ys+1);pgreen(2000,'Tekan Sembarang Tombol Untuk Kembali Ke Menu Utama ');
               choice := 3;
               readkey;
             end else
             begin
             clrscr;
             show_user_menu;
             py:=wherey ;
             gotoxy(xs,py);write('Silahkan Masukan Pilihan Anda : ');readln(dumy);
             choice := validate_choice(dumy,3);
             while ( choice < 0 ) do
               begin
                  dcl(xs,py);
                  gotoxy(xs,py);print_red('Maaf, menu yang anda masukan salah !!');
                  readkey;
                  dcl(xs,py);
                  gotoxy(xs,py);write('Silahkan Masukan Pilihan Anda : ');readln(dumy);
                  choice := validate_choice(dumy,3)
               end;
               if (choice = 1) then
                 begin
                   clrscr;
                   gotoxy(xs,ys-1);writeln('Menambah Pengguna Baru ');
                   gotoxy(xs,ys);writeln('-----------------------');
                   gotoxy(xs,ys+1);write('Masukan Username Pengguna Baru : ');readln(p);
                   while isblank(p) do
                   begin
                        dcl(xs,ys+1);
                        print_red('Username tidak boleh kosong !!');
                        readkey;
                        dcl(xs,ys+1);
                        gotoxy(xs,ys+1);write('Masukan Username Pengguna Baru : ');readln(p)
                   end;
                   gotoxy(xs,ys+2);write('Masukan Password Pengguna Baru : ');readln(q);
                   while isblank(q) do
                   begin
                        dcl(xs,ys+2);
                        gotoxy(xs,ys+2);print_red('Password tidak boleh kosong !!');
                        readkey;
                        dcl(xs,ys+2);
                        gotoxy(xs,py+2);write('Silahkan Masukan Pilihan Anda : ');readln(q);
                   end;
                   py:=wherey+1;
                   gotoxy(xs,py);print_blue('Yakin Akan menambah User Berikut ini ? ');
                   gotoxy(xs,py+1);write('nama : ',p,'   password : ',q,' [y/n] : ');readln(dumy);
                   while (isblank(dumy) or not is_yesornot(dumy)) do
                   begin
                        dcl(xs,py+1);
                        gotoxy(xs,py+1);print_red('Hanya karakter "y" atau "n" yang diizinkan !! ');
                        readkey;
                        dcl(xs,py+1);
                        gotoxy(xs,py+1);write('nama : ',p,'   password : ',q,' [y/n] : ');readln(dumy);
                   end;
                   if (dumy='y') or (dumy='Y') then
                   begin
                        add_user(p,q);
                        gotoxy(xs,py+3);
                        pgreen(2000,'Pengguna Baru sudah ditambahkan, tekan sembarang tombol ');
                        readkey;
                   end else begin gotoxy(xs,py+3);pgreen(2000,'Operasi dibatalkan, tekan sembarang tombol ');readkey;end;
                 end else
                 if ( choice=2 ) then
                 begin
                     clrscr;
                     gotoxy(xs,ys);print_blue('Menghapus Pengguna ');
                     gotoxy(xs,ys+1); writeln('-------------------');
                     gotoxy(xs,ys+2); writeln('Daftar User yang terdaftar adalah ');
                     gotoxy(xs,ys+4);
                     assign(f1,'username.txt');
                     reset(f1);
                     x:=0;
                     while not eof(f1) do
                     begin
                        inc(x);
                        readln(f1,dumy);
                        gotoxy(xs,wherey);writeln('NO ID - ',x,' dengan username : ',dumy);
                     end;
                     close(f1);
                     py := wherey+1;
                     gotoxy(xs,py);writeln('------------------------------------------------------------');
                     gotoxy(xs,py);write('Masukan NO ID username yang akan dihapus atau 0 untuk batal : ');readln(dumy);
                     y:= isnumber(dumy);
                     if y<>0 then validate_choice(dumy,get_total_user);
                     while (y<0) or (y=1) do
                     begin

                        dcl(xs,py);
                        gotoxy(xs,py);
                        if not( y=1) then
                        print_red('Maaf, username tidak ditemukan atau input salah !!')
                        else print_red('Maaf, anda tak dapat menghapus account administrator !!');
                        readkey;
                        dcl(xs,py);
                        gotoxy(xs,py);
                        write('Masukan NO ID username yang akan dihapus atau 0 untuk batal : ');readln(dumy);
                        y:= validate_choice(dumy,get_total_user);
                     end;
                     py:=wherey+1;
                     if y=0 then begin gotoxy(xs,py);pgreen(2000,'Operasi dibatalkan, tekan sembarang tombol untuk kembali ');readkey;break; end;
                     clrscr;
                     gotoxy(xs,ys);
                     py:=wherey;
                     gotoxy(xs,py);writeln('Anda Akan menghapus username - ',get_user_from_id(y));
                     gotoxy(xs,py+2);print_red('Peringatan ! Penghapusan yang sudah dilakukan tidak bisa dibatalkan ! ');
                     gotoxy(xs,py+3);  writeln('----------------------------------------------------------------------');
                     py:=py+5;
                     gotoxy(xs,py);write('Yakin akan menghapus ?, masukan pilihan [y/n] : ');readln(dumy);


                     while (isblank(dumy) or not is_yesornot(dumy)) do
                     begin
                       dcl(xs,py);
                       gotoxy(xs,py);print_red('Input hanya boleh berupa karakter "n" atau "y" !! ');
                       readkey;
                       dcl(xs,py);
                       gotoxy(xs,py);write('Yakin akan menghapus ?, masukan pilihan [y/n] : ');readln(dumy);
                     end;


                     if (dumy='y') or (dumy='Y') then
                      begin
                         delete_user(y);
                         gotoxy(xs,py+2);pgreen(2000,'Data sudah dihapus, tekan sembarang tombol untuk kembali ');
                         readkey;
                      end
                      else
                      begin
                         gotoxy(xs,py+2);
                         pgreen(2000,'Operasi dibatalkan, tekan sembarang tombol untuk kembali ');
                         readkey;
                      end;




                 end;{ end of choice =2 }
               end;
          end; { end of inner loop }
      end { end main choice = 5 }
      else
      if select_main_menu = 6 then
      begin
         py:=wherey+2;
         gotoxy(xs,py);
         pgreen(3000,'Terima Kasih Sudah Menggunakan Program Management Kos ');
      end;
   end;{ end outher loop }


   end; { end of auth }

end.
