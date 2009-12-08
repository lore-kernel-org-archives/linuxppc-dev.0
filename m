Return-Path: <solyn123@gmail.com>
Received: from mail-px0-f190.google.com (mail-px0-f190.google.com
	[209.85.216.190]) by ozlabs.org (Postfix) with ESMTP id AD0C8B7BFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 17:35:48 +1100 (EST)
Received: by pxi28 with SMTP id 28so984376pxi.7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Dec 2009 22:35:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
	<20091207180511.GA8914@loki.buserror.net>
	<8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
Date: Tue, 8 Dec 2009 14:35:47 +0800
Message-ID: <8148211e0912072235i76c6f24ence788122681a8407@mail.gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
From: =?GB2312?B?wdbWvsa9?= <solyn123@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001636e90bf7c44143047a31c878
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e90bf7c44143047a31c878
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

PING works now, after modifying the code of gianfar-mii.c

2009/12/8 =C1=D6=D6=BE=C6=BD <solyn123@gmail.com>

>
> 2009/12/8 Scott Wood <scottwood@freescale.com>
>
>  On Mon, Dec 07, 2009 at 11:53:22AM +0800, =C1=D6=D6=BE=C6=BD wrote:
>> > Does dtc1.2.0 can compile dts files under linux2.6.23?
>>
>> Probably not -- 2.6.23 is very old, and I think newer dtcs only support
>> the
>> newer dts syntax.
>>
>> > Another question is that I found linux2.6.31 does not support
>> > board mpc8544ds,
>>
>> It should.  What problems do you see?
>
> =3D> bootm 0x1000000 0x1800000 0x800000
> ## Booting kernel from Legacy Image at 01000000 ...
>    Image Name:   Linux-2.6.31
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2185099 Bytes =3D  2.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 01800000 ...
>    Image Name:   Simple Embedded Linux Framework
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1859256 Bytes =3D  1.8 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 00800000
>    Booting using the fdt blob at 0x800000
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 1fca7000, end 1fe6ceb8 ... OK
> booting kernel using flat tree
> It then stops and never print any more,  I use mpc85xx_defconfig, I selec=
t
> mpc85xxds in the menuconfig and deselect other options like mpc8540ads et=
c.
>
>>
>> > And I never boot linux-2.6.31 on my board, why linux-2.6.31 doesnot
>> > provide a config file like mpc8544_ds_defconfig?
>>
>> Does mpc85xx_defconfig not work?
>>
> Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the
> menuconfig, but no mpc8544ds. And when I down load the generated uImage, =
It
> does not work.
>
>
>> -Scott
>>
>
>

--001636e90bf7c44143047a31c878
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>PING works now, after modifying the code of gianfar-mii.c<br><br></div=
>
<div class=3D"gmail_quote">2009/12/8 =C1=D6=D6=BE=C6=BD <span dir=3D"ltr">&=
lt;<a href=3D"mailto:solyn123@gmail.com">solyn123@gmail.com</a>&gt;</span><=
br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><br>
<div class=3D"gmail_quote">2009/12/8 Scott Wood <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:scottwood@freescale.com" target=3D"_blank">scottwood@freescale=
.com</a>&gt;</span>=20
<div class=3D"im"><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>On Mon, Dec 07, 2009 at 11:53:22AM +0800, =C1=D6=D6=BE=C6=BD wrote:<br=
>&gt; Does dtc1.2.0 can compile dts files under linux2.6.23?<br><br></div>P=
robably not -- 2.6.23 is very old, and I think newer dtcs only support the<=
br>newer dts syntax.<br>

<div><br>&gt; Another question is that I found linux2.6.31 does not support=
<br>&gt; board mpc8544ds,<br><br></div>It should. &nbsp;What problems do yo=
u see?</blockquote></div>
<div>=3D&gt; bootm 0x1000000 0x1800000 0x800000<br>## Booting kernel from L=
egacy Image at 01000000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2=
.6.31<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (g=
zip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2185099 Bytes =
=3D&nbsp; 2.1 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 0000=
0000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>## Loading init Ramdisk f=
rom Legacy Image at 01800000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Si=
mple Embedded Linux Framework<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; Power=
PC Linux RAMDisk Image (gzip compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1859256 Bytes =3D&nbsp; 1.8 MB<br=
>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 000=
00000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>## Flattened Device Tree=
 blob at 00800000<br>&nbsp;&nbsp; Booting using the fdt blob at 0x800000<br=
>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>&nbsp;&nbsp; Loading Ramd=
isk to 1fca7000, end 1fe6ceb8 ... OK<br>booting kernel using flat tree</div=
>
<div>It then stops and never print any more,&nbsp; I use mpc85xx_defconfig,=
 I select mpc85xxds in the menuconfig and deselect other options like mpc85=
40ads etc.<br></div>
<div class=3D"im">
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div><br>&gt; And I never boot linux-2.6.31 on my board, why linux-2.6.31 d=
oesnot<br>&gt; provide a config file like mpc8544_ds_defconfig?<br><br></di=
v>Does mpc85xx_defconfig not work?<br></blockquote></div>
<div>Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the menuc=
onfig, but no mpc8544ds. And when I down load the generated uImage, It does=
 not work.</div>
<div>&nbsp;</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><font color=3D"#888888">-Scott<b=
r></font></blockquote></div><br></blockquote></div><br>

--001636e90bf7c44143047a31c878--
