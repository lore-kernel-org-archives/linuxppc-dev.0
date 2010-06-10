Return-Path: <skrishnakar@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id CF2F11007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 17:04:58 +1000 (EST)
Received: by vws6 with SMTP id 6so5507970vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 00:04:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BAY152-w7029D1872C3896BB5E40DBCD70@phx.gbl>
References: <BAY152-w7029D1872C3896BB5E40DBCD70@phx.gbl>
Date: Thu, 10 Jun 2010 12:34:56 +0530
Message-ID: <AANLkTimQNPb0WAvAk6mNAsy25k0OZ482EwLCD0wlukvl@mail.gmail.com>
Subject: Re: Port Linux to ML510
From: srikanth krishnakar <skrishnakar@gmail.com>
To: kostas padarnitsas <kpada84@hotmail.com>
Content-Type: multipart/alternative; boundary=00c09f88ceb0d434a40488a7a3f9
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f88ceb0d434a40488a7a3f9
Content-Type: text/plain; charset=ISO-8859-1

Hi kostas,

You need to verify that the driver version of serial and Ethernet (probably
X-LLTEMAC) provided in the virtex440.dts matches version used in kernel.
Look for "compatible = <version>" in the drivers. You can probably use EDK
11.2 as it is the latest from Xilinx.

Have you generated your own DTS and Bitstream (download.bit) files ?

If not then you should look for suitable download.bit for you kernel.

-Srikant

2010/6/10 kostas padarnitsas <kpada84@hotmail.com>

>  Hello,
>
> I am trying to port Linux to PowerPC on the ML510 Xilinx board. I am using
> EDK 10.1.3 to build the hardware and also device tree generator and the
> linux kernel from xilinx git. I followed the tutorial from
> http://xilinx.wikidot.com/powerpc-linux but I have no output. I have
> attached my .mhs file and the .dts.  Any ideas what may cause this problem
> because I did the same thing with ML507 and it was working perfectly?
>
> Thanks in advance,
> Kostas
>
> ------------------------------
> Your E-mail and More On-the-Go. Get Windows Live Hotmail Free. Sign up
> now. <https://signup.live.com/signup.aspx?id=60969>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--00c09f88ceb0d434a40488a7a3f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi kostas,<br><br>You need to verify that the driver version of serial and =
Ethernet (probably X-LLTEMAC) provided in the virtex440.dts matches version=
 used in kernel. Look for &quot;compatible =3D &lt;version&gt;&quot; in the=
 drivers. You can probably use EDK 11.2 as it is the latest from Xilinx. <b=
r>
<br>Have you generated your own DTS and Bitstream (download.bit) files ?<br=
><br>If not then you should look for suitable download.bit for you kernel.<=
br><br>-Srikant<br><br><div class=3D"gmail_quote">2010/6/10 kostas padarnit=
sas <span dir=3D"ltr">&lt;<a href=3D"mailto:kpada84@hotmail.com">kpada84@ho=
tmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">



<div>
Hello,<div><br></div><div>I am trying to port Linux to PowerPC on the ML510=
 Xilinx board. I am using EDK 10.1.3 to build the hardware and also device =
tree generator and the linux kernel from xilinx git. I followed the tutoria=
l from=A0<a href=3D"http://xilinx.wikidot.com/powerpc-linux" target=3D"_bla=
nk">http://xilinx.wikidot.com/powerpc-linux</a>=A0but I have no output. I h=
ave attached my .mhs file and the .dts. =A0Any ideas what may cause this pr=
oblem because I did the same thing with ML507 and it was working perfectly?=
</div>
<div><br></div><div>Thanks in advance,</div><div>Kostas</div><font color=3D=
"#888888"> 		 	   		  </font><br><div class=3D"hm"><hr>Your E-mail and More=
 On-the-Go. Get Windows Live Hotmail Free. <a href=3D"https://signup.live.c=
om/signup.aspx?id=3D60969" target=3D"_blank">Sign up now.</a></div>
</div>
<br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br></blockquote></div>=
<br><br clear=3D"all"><br>-- <br>&quot;The Good You Do, The Best You GET&qu=
ot;<br>
<br>Regards<br>Srikanth Krishnakar<br>**********************<br>

--00c09f88ceb0d434a40488a7a3f9--
