Return-Path: <solyn123@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 33363B6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 00:05:10 +1100 (EST)
Received: by pwi13 with SMTP id 13so2173360pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 05:05:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B2001A3.9010002@freescale.com>
References: <8148211e0912061953n59dfbe4fsea033494ad8b6fcc@mail.gmail.com>
	<20091207180511.GA8914@loki.buserror.net>
	<8148211e0912071825t22ffa590va2fe22272f6aaf62@mail.gmail.com>
	<4B2001A3.9010002@freescale.com>
Date: Thu, 10 Dec 2009 21:05:09 +0800
Message-ID: <8148211e0912100505r46a813dcgc907a79e153ca8e@mail.gmail.com>
Subject: Re: Ping does not work on my MPC8544 board, using linux2.6.23
From: =?GB2312?B?wdbWvsa9?= <solyn123@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=0016368e230ef4104e047a5f74c0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016368e230ef4104e047a5f74c0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

2009/12/10 Scott Wood <scottwood@freescale.com>

>  =C1=D6=D6=BE=C6=BD wrote:
>
>>     > Another question is that I found linux2.6.31 does not support
>>     > board mpc8544ds,
>>
>>    It should.  What problems do you see?
>>
>> =3D> bootm 0x1000000 0x1800000 0x800000
>> ## Booting kernel from Legacy Image at 01000000 ...
>>   Image Name:   Linux-2.6.31
>>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>   Data Size:    2185099 Bytes =3D  2.1 MB
>>   Load Address: 00000000
>>   Entry Point:  00000000
>>   Verifying Checksum ... OK
>> ## Loading init Ramdisk from Legacy Image at 01800000 ...
>>   Image Name:   Simple Embedded Linux Framework
>>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>>   Data Size:    1859256 Bytes =3D  1.8 MB
>>   Load Address: 00000000
>>   Entry Point:  00000000
>>   Verifying Checksum ... OK
>> ## Flattened Device Tree blob at 00800000
>>   Booting using the fdt blob at 0x800000
>>   Uncompressing Kernel Image ... OK
>>   Loading Ramdisk to 1fca7000, end 1fe6ceb8 ... OK
>> booting kernel using flat tree
>> It then stops and never print any more,  I use mpc85xx_defconfig, I sele=
ct
>> mpc85xxds in the menuconfig and deselect other options like mpc8540ads e=
tc.
>>
>
> Are you using the mpc8544ds device tree from 2.6.31, unchanged?  Try
> turning on CONFIG_PPC_EARLY_DEBUG.
>
> No need to deselect the others, BTW.


>    Does mpc85xx_defconfig not work?
>>
>> Yes mcp85xx_defconfig does not work, I can see mpc8540ads in the
>> menuconfig, but no mpc8544ds.
>>
>
> mpc8544ds is supported by CONFIG_MPC85xx_DS.
> CONFIG_MPC85XX_DS does not exist. Only mpc85xx_defconfig in
> arch/powerpc/configs



> -Scott
>

--0016368e230ef4104e047a5f74c0
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<br>
<div class=3D"gmail_quote">2009/12/10 Scott Wood <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;</spa=
n><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div>
<div></div>
<div class=3D"h5">=C1=D6=D6=BE=C6=BD wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">&nbsp; &nbsp; &gt; Another quest=
ion is that I found linux2.6.31 does not support<br>&nbsp; &nbsp; &gt; boar=
d mpc8544ds,<br><br>
&nbsp; &nbsp;It should. &nbsp;What problems do you see?<br><br>=3D&gt; boot=
m 0x1000000 0x1800000 0x800000<br>## Booting kernel from Legacy Image at 01=
000000 ...<br>&nbsp; Image Name: &nbsp; Linux-2.6.31<br>&nbsp; Image Type: =
&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>
&nbsp; Data Size: &nbsp; &nbsp;2185099 Bytes =3D &nbsp;2.1 MB<br>&nbsp; Loa=
d Address: 00000000<br>&nbsp; Entry Point: &nbsp;00000000<br>&nbsp; Verifyi=
ng Checksum ... OK<br>## Loading init Ramdisk from Legacy Image at 01800000=
 ...<br>&nbsp; Image Name: &nbsp; Simple Embedded Linux Framework<br>
&nbsp; Image Type: &nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>=
&nbsp; Data Size: &nbsp; &nbsp;1859256 Bytes =3D &nbsp;1.8 MB<br>&nbsp; Loa=
d Address: 00000000<br>&nbsp; Entry Point: &nbsp;00000000<br>&nbsp; Verifyi=
ng Checksum ... OK<br>## Flattened Device Tree blob at 00800000<br>
&nbsp; Booting using the fdt blob at 0x800000<br>&nbsp; Uncompressing Kerne=
l Image ... OK<br>&nbsp; Loading Ramdisk to 1fca7000, end 1fe6ceb8 ... OK<b=
r>booting kernel using flat tree<br>It then stops and never print any more,=
 &nbsp;I use mpc85xx_defconfig, I select mpc85xxds in the menuconfig and de=
select other options like mpc8540ads etc.<br>
</blockquote><br></div></div>Are you using the mpc8544ds device tree from 2=
.6.31, unchanged? &nbsp;Try turning on CONFIG_PPC_EARLY_DEBUG.<br><br>No ne=
ed to deselect the others, BTW. </blockquote>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">
<div class=3D"im"><br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">&nbsp; &nbsp;Does mpc85xx_defcon=
fig not work?<br><br>Yes mcp85xx_defconfig does not work, I can see mpc8540=
ads in the menuconfig, but no mpc8544ds.<br>
</blockquote><br></div>mpc8544ds is supported by CONFIG_MPC85xx_DS.<br>CONF=
IG_MPC85XX_DS does not exist. Only mpc85xx_defconfig in arch/powerpc/config=
s</blockquote>
<div>&nbsp;</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote"><font color=3D"#888888">-Scott<b=
r></font></blockquote></div><br>

--0016368e230ef4104e047a5f74c0--
