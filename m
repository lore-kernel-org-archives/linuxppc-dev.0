Return-Path: <vasim98@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96AE0B6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 05:22:39 +1000 (EST)
Received: by eyg5 with SMTP id 5so2073641eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 12:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTin5TyfdfNDfXokDdtdpDmnoRQ6aAA@mail.gmail.com>
References: <BANLkTims8CrK6s0bJZPBt3jTDRDKzg2e-A@mail.gmail.com>
	<20110523124035.GJ25179@zod.rchland.ibm.com>
	<BANLkTin5TyfdfNDfXokDdtdpDmnoRQ6aAA@mail.gmail.com>
From: Muhammad Waseem <vasim98@gmail.com>
Date: Tue, 24 May 2011 00:22:14 +0500
Message-ID: <BANLkTikvmy-bkckgxyQttoKQqkuNUd2+5g@mail.gmail.com>
Subject: Fwd: UART #1 access on Sequoia board
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174c1110bae39604a3f664b5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174c1110bae39604a3f664b5
Content-Type: text/plain; charset=ISO-8859-1

I am using kernel version 2.6.23 which came with the Sequoia support CD. So
that means UART # 1 BSP would probably not there?  But device file
/dev/ttyS1 is present in rootfs when listed using 'ls'. Do you think
updating the kernel might solve the problem?

BTW where can I see the board's DTS file?

--
Waseem




On Mon, May 23, 2011 at 5:40 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com>wrote:

> On Mon, May 23, 2011 at 11:34:26AM +0500, Muhammad Waseem wrote:
> >Hello,
> >   I am working on PPC440EPx (Sequoia) to access its UART # 1 port for
> data
> >transfer, while UART # 0 is connected to remote terminal access on host.
> >However there is no module/driver listed for UART # 1 using 'lsmod'. The
> >kernel version is 2.6.23. How can I access the UART # 1 in user space
> and/or
> >kernel space? Do I need to develop own BSP for this? please help.
>
> The driver is normally built into the kernel.  If the board DTS file has
> both UARTs listed, and you have /dev/ttyS1 on your rootfs you should be
> able to use it.  However, Sequoia wasn't added until 2.6.24, so I'm not
> really sure what kernel flavor you are using.
>
> josh
>

--0015174c1110bae39604a3f664b5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">I am using kernel version 2.6.23 which came with=
 the Sequoia support CD. So that means UART # 1 BSP would probably not ther=
e? =A0But device file /dev/ttyS1 is present in rootfs when listed using &#3=
9;ls&#39;. Do you think updating the kernel might solve the problem?<div>


<br></div><div>BTW where can I see the board&#39;s DTS file?</div><div><br>=
<div>--</div><div>Waseem</div><div><div></div><div class=3D"h5"><div><br><d=
iv><br><div>=A0=A0<br><br><div class=3D"gmail_quote">On Mon, May 23, 2011 a=
t 5:40 PM, Josh Boyer <span dir=3D"ltr">&lt;<a href=3D"mailto:jwboyer@linux=
.vnet.ibm.com" target=3D"_blank">jwboyer@linux.vnet.ibm.com</a>&gt;</span> =
wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div></div><div>On Mon, May 23, 2011 at=
 11:34:26AM +0500, Muhammad Waseem wrote:<br>
&gt;Hello,<br>
&gt; =A0 I am working on PPC440EPx (Sequoia) to access its UART # 1 port fo=
r data<br>
&gt;transfer, while UART # 0 is connected to remote terminal access on host=
.<br>
&gt;However there is no module/driver listed for UART # 1 using &#39;lsmod&=
#39;. The<br>
&gt;kernel version is 2.6.23. How can I access the UART # 1 in user space a=
nd/or<br>
&gt;kernel space? Do I need to develop own BSP for this? please help.<br>
<br>
</div></div>The driver is normally built into the kernel. =A0If the board D=
TS file has<br>
both UARTs listed, and you have /dev/ttyS1 on your rootfs you should be<br>
able to use it. =A0However, Sequoia wasn&#39;t added until 2.6.24, so I&#39=
;m not<br>
really sure what kernel flavor you are using.<br>
<font color=3D"#888888"><br>
josh<br>
</font></blockquote></div><br></div></div></div></div></div></div>
</div><br>

--0015174c1110bae39604a3f664b5--
