Return-Path: <skrishnakar@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id F2CFEB7D7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Jun 2010 18:56:25 +1000 (EST)
Received: by vws8 with SMTP id 8so439147vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Jun 2010 01:56:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BAY152-w58B66B551376FF621F6E4DBCD80@phx.gbl>
References: <BAY152-w7029D1872C3896BB5E40DBCD70@phx.gbl>
	<AANLkTimQNPb0WAvAk6mNAsy25k0OZ482EwLCD0wlukvl@mail.gmail.com>
	<BAY152-w58B66B551376FF621F6E4DBCD80@phx.gbl>
Date: Mon, 14 Jun 2010 14:26:23 +0530
Message-ID: <AANLkTilRLojabi90kjHzeGwiEqF0guFf6wFC1qBO4gu_@mail.gmail.com>
Subject: Re: Port Linux to ML510
From: srikanth krishnakar <skrishnakar@gmail.com>
To: kostas padarnitsas <kpada84@hotmail.com>
Content-Type: multipart/alternative; boundary=0016e6464e08c8e7e10488f9a992
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6464e08c8e7e10488f9a992
Content-Type: text/plain; charset=ISO-8859-1

If any changes w.r.t board then John Linn (XILINX) should be able to provide
some pointers.


2010/6/11 kostas padarnitsas <kpada84@hotmail.com>

>  Hi Srikant,
>
> Thanks for your help. I checked the driver versions and they seem ok. The
> problem is that when I download the linux image the program counter is not
> set to the address of boot sector of linux kernel, so linux doesn't boot. On
> the other hand with the ML507 everything works perfectly. Any idea??
>
> Thanks in advance,
> Kostas
>
> ------------------------------
> Date: Thu, 10 Jun 2010 12:34:56 +0530
> Subject: Re: Port Linux to ML510
> From: skrishnakar@gmail.com
> To: kpada84@hotmail.com
> CC: linuxppc-dev@lists.ozlabs.org
>
>
> Hi kostas,
>
> You need to verify that the driver version of serial and Ethernet (probably
> X-LLTEMAC) provided in the virtex440.dts matches version used in kernel.
> Look for "compatible = <version>" in the drivers. You can probably use EDK
> 11.2 as it is the latest from Xilinx.
>
> Have you generated your own DTS and Bitstream (download.bit) files ?
>
> If not then you should look for suitable download.bit for you kernel.
>
> -Srikant
>
> 2010/6/10 kostas padarnitsas <kpada84@hotmail.com>
>
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
>
>
>
> --
> "The Good You Do, The Best You GET"
>
> Regards
> Srikanth Krishnakar
> **********************
>
> ------------------------------
> Hotmail: Free, trusted and rich email service. Get it now.<https://signup.live.com/signup.aspx?id=60969>
>



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--0016e6464e08c8e7e10488f9a992
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If any changes w.r.t board then John Linn (XILINX) should be able to provid=
e some pointers.<br><br><div class=3D"gmail_quote"><br>2010/6/11 kostas pad=
arnitsas <span dir=3D"ltr">&lt;<a href=3D"mailto:kpada84@hotmail.com">kpada=
84@hotmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">



<div>
Hi Srikant,<div><br></div><div>Thanks for your help. I checked the driver v=
ersions and they seem ok. The problem is that when I download the linux ima=
ge the program counter is not set to the address of boot sector of linux ke=
rnel, so linux doesn&#39;t boot. On the other hand with the ML507 everythin=
g works perfectly. Any idea??</div>
<div><br></div><div>Thanks in advance,</div><div>Kostas<br><br><hr>Date: Th=
u, 10 Jun 2010 12:34:56 +0530<br>Subject: Re: Port Linux to ML510<br>From: =
<a href=3D"mailto:skrishnakar@gmail.com" target=3D"_blank">skrishnakar@gmai=
l.com</a><br>
To: <a href=3D"mailto:kpada84@hotmail.com" target=3D"_blank">kpada84@hotmai=
l.com</a><br>CC: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org" target=3D=
"_blank">linuxppc-dev@lists.ozlabs.org</a><div><div></div><div class=3D"h5"=
><br><br>
Hi kostas,<br><br>You need to verify that the driver version of serial and =
Ethernet (probably X-LLTEMAC) provided in the virtex440.dts matches version=
 used in kernel. Look for &quot;compatible =3D &lt;version&gt;&quot; in the=
 drivers. You can probably use EDK 11.2 as it is the latest from Xilinx. <b=
r>

<br>Have you generated your own DTS and Bitstream (download.bit) files ?<br=
><br>If not then you should look for suitable download.bit for you kernel.<=
br><br>-Srikant<br><br><div>2010/6/10 kostas padarnitsas <span dir=3D"ltr">=
&lt;<a href=3D"mailto:kpada84@hotmail.com" target=3D"_blank">kpada84@hotmai=
l.com</a>&gt;</span><br>

<blockquote style=3D"padding-left: 1ex;">



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
"#888888"> 		 	   		  </font><br><div><hr>Your E-mail and More On-the-Go. G=
et Windows Live Hotmail Free. <a href=3D"https://signup.live.com/signup.asp=
x?id=3D60969" target=3D"_blank">Sign up now.</a></div>

</div>
<br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br></blockquote></div>=
<br><br clear=3D"all"><br>-- <br>&quot;The Good You Do, The Best You GET&qu=
ot;<br>

<br>Regards<br>Srikanth Krishnakar<br>**********************<br></div></div=
></div><div class=3D"hm"> 		 	   		  <br><hr>Hotmail: Free, trusted and ric=
h email service. <a href=3D"https://signup.live.com/signup.aspx?id=3D60969"=
 target=3D"_blank">Get it now.</a></div>
</div>
</blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good You Do, =
The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>***********=
***********<br>

--0016e6464e08c8e7e10488f9a992--
