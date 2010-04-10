Return-Path: <csdncannon@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id BD616B7CF5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 13:14:10 +1000 (EST)
Received: by pzk33 with SMTP id 33so3240888pzk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Apr 2010 20:14:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
Date: Sat, 10 Apr 2010 11:14:09 +0800
Message-ID: <o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Csdncannon <csdncannon@gmail.com>
To: linuxppc-dev@ozlabs.org, zhouminggang@hotmail.com
Content-Type: multipart/mixed; boundary=0016e64dc98629d4840483d94ea3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e64dc98629d4840483d94ea3
Content-Type: multipart/alternative; boundary=0016e64dc98629d47a0483d94ea1

--0016e64dc98629d47a0483d94ea1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Sorry, I attached the wrong log, this attachment is the right one.


2010/3/25 Csdncannon <csdncannon@gmail.com>

>          In my program, the value of the 64-bit time base register is rea=
d
> out, and you will find the later value is even smaller than the earlier
> value from the log =93log_timebase=94. While the kernel depends on the ac=
curacy
> of the timebase for the compensation of the lost PIT interrupt, the negat=
ive
> value between two continual timebase reading will bring to the jump of th=
e
> jiffies. And this timebase problem will bring to the instability of the
> gettimeofday system call.
>
>          Do you have any idea about this problem, thanks for your any
> advice. Attached is the code and log.
>
>
> Thanks
>
> Gino
>
>
>
>

--0016e64dc98629d47a0483d94ea1
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Sorry, I attached the wrong log, this attachment is the right one.<br><br><=
br><div class=3D"gmail_quote">2010/3/25 Csdncannon <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:csdncannon@gmail.com">csdncannon@gmail.com</a>&gt;</span><b=
r><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<p class=3D"MsoNormal"><font color=3D"navy" face=3D"Arial" size=3D"4"><span=
 style=3D"color: navy; font-family: Arial;" lang=3D"EN-US">=A0=A0=A0=A0=A0=
=A0=A0=A0 In my program, the value of the 64-bit time base register is read=
 out, and you=20
will find the later value is even smaller than the earlier value from the l=
og=20
=93log_timebase=94. While the kernel depends on the accuracy of the timebas=
e for the=20
compensation of the lost PIT interrupt, the negative value between two cont=
inual=20
timebase reading will bring to the jump of the jiffies. And this timebase=
=20
problem will bring to the instability of the gettimeofday system call.</spa=
n></font></p><p class=3D"MsoNormal"><font color=3D"navy"><font size=3D"4"><=
font face=3D"Arial">=A0=A0=A0=A0=A0=A0=A0=A0 Do you have any idea about thi=
s problem, thanks for your any advice. Attached is the code and log.</font>=
</font></font></p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Thanks</p><p class=3D=
"MsoNormal">Gino<br><font color=3D"navy" face=3D"Arial" size=3D"4"><span st=
yle=3D"color: navy; font-family: Arial;" lang=3D"EN-US"></span></font></p><=
p class=3D"MsoNormal">

<br><font color=3D"navy" face=3D"Arial" size=3D"1"><span style=3D"font-size=
: 9pt; color: navy; font-family: Arial;" lang=3D"EN-US"></span></font></p>
<p class=3D"MsoNormal"><font color=3D"navy" face=3D"Arial" size=3D"1"><span=
 style=3D"font-size: 9pt; color: navy; font-family: Arial;" lang=3D"EN-US">=
=A0</span></font></p>
</blockquote></div><br>

--0016e64dc98629d47a0483d94ea1--

--0016e64dc98629d4840483d94ea3
Content-Type: application/octet-stream; name="gettime.log"
Content-Disposition: attachment; filename="gettime.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7tuqcps2

cm9vdEB0bGFiODM3ODovcm9vdD4gL21udC9zZXJ2ZXIvR2luby9nZXR0aW1lDQogMTI3MDU0MDc0
NCAsICAgMTI3MDU0MDc0NA0KRmFpbGVkIDogdGltZW91dCAxMjcwNTQwNzQ5ICwgbm93IDEyNzA1
NTgzNDENClNlcmlvdXMgOiB0aW1lb3V0IDEyNzA1NTgzNDEgLCBub3cgMTI3MDU0MDc0OQ0KIDEy
NzA1NDA3NTUgLCAgIDEyNzA1NDA3NTUNCiAxMjcwNTQwNzY1ICwgICAxMjcwNTQwNzY1DQpGYWls
ZWQgOiB0aW1lb3V0IDEyNzA1NDA3NzQgLCBub3cgMTI3MDU1ODM2Ng0KU2VyaW91cyA6IHRpbWVv
dXQgMTI3MDU1ODM2NiAsIG5vdyAxMjcwNTQwNzc0DQogMTI3MDU0MDc3NSAsICAgMTI3MDU0MDc3
NQ0KIDEyNzA1NDA3ODYgLCAgIDEyNzA1NDA3ODYNCiAxMjcwNTQwNzk2ICwgICAxMjcwNTQwNzk2
DQpGYWlsZWQgOiB0aW1lb3V0IDEyNzA1NDA4MDIgLCBub3cgMTI3MDU1ODM5NA0KU2VyaW91cyA6
IHRpbWVvdXQgMTI3MDU1ODM5NCAsIG5vdyAxMjcwNTQwODAyDQpGYWlsZWQgOiB0aW1lb3V0IDEy
NzA1NDA4MDMgLCBub3cgMTI3MDU1ODM5NQ0KU2VyaW91cyA6IHRpbWVvdXQgMTI3MDU1ODM5NSAs
IG5vdyAxMjcwNTQwODAzDQogMTI3MDU0MDgwNiAsICAgMTI3MDU0MDgwNg0KRmFpbGVkIDogdGlt
ZW91dCAxMjcwNTQwODE0ICwgbm93IDEyNzA1NTg0MDYNClNlcmlvdXMgOiB0aW1lb3V0IDEyNzA1
NTg0MDYgLCBub3cgMTI3MDU0MDgxNA0KIDEyNzA1NDA4MTYgLCAgIDEyNzA1NDA4MTYNCiAxMjcw
NTQwODI3ICwgICAxMjcwNTQwODI3DQogMTI3MDU0MDgzNyAsICAgMTI3MDU0MDgzNw0KIDEyNzA1
NDA4NDcgLCAgIDEyNzA1NDA4NDcNCkZhaWxlZCA6IHRpbWVvdXQgMTI3MDU0MDg1NSAsIG5vdyAx
MjcwNTU4NDQ3DQpTZXJpb3VzIDogdGltZW91dCAxMjcwNTU4NDQ3ICwgbm93IDEyNzA1NDA4NTUN
CiAxMjcwNTQwODU4ICwgICAxMjcwNTQwODU4
--0016e64dc98629d4840483d94ea3--
