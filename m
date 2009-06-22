Return-Path: <lada.podivin@gmail.com>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 34553B7197
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 21:31:36 +1000 (EST)
Received: by bwz26 with SMTP id 26so3461835bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 04:31:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200906221123.11192.sr@denx.de>
References: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
	<200906221123.11192.sr@denx.de>
Date: Mon, 22 Jun 2009 13:31:32 +0200
Message-ID: <e35801cc0906220431v541c7901lb23be9e2adf2de09@mail.gmail.com>
Subject: Re: kilauea/405ex external interrupts
From: Lada Podivin <lada.podivin@gmail.com>
To: Stefan Roese <sr@denx.de>
Content-Type: multipart/alternative; boundary=001636c5a345486bfe046cee37bd
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c5a345486bfe046cee37bd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks for replies!

2009/6/22 Stefan Roese <sr@denx.de>


> Yes, this could very well be a problem of pin multiplexing. From looking at
> the Kilauea GPIO/Pin mux configuration in U-Boot, GPIO30 is configured as
> GPIO
> input and not as IRQ1. So this can't work. The easiest way to change this
> is
> in U-Boot (include/configs/kilauea.h).
>

Right, the pin multiplexing was the problem. I didn't know that U-BOOT can
do that - very useful information, thank you again!

>
> BTW: Are you using Kilauea or a custom 405EX board?
>
> Best regards,
> Stefan
>
>
Yes, it's the Kilauea board.

--001636c5a345486bfe046cee37bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for replies!<br><br><div class=3D"gmail_quote">2009/6/22 Stefan Roes=
e <span dir=3D"ltr">&lt;<a href=3D"mailto:sr@denx.de">sr@denx.de</a>&gt;</s=
pan><br><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
<div class=3D"im">
</div>Yes, this could very well be a problem of pin multiplexing. From look=
ing at<br>
the Kilauea GPIO/Pin mux configuration in U-Boot, GPIO30 is configured as G=
PIO<br>
input and not as IRQ1. So this can&#39;t work. The easiest way to change th=
is is<br>
in U-Boot (include/configs/kilauea.h).<br>
</blockquote><div><br>Right, the pin multiplexing was the problem. I didn&#=
39;t know that U-BOOT can do that - very useful information, thank you agai=
n!<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
BTW: Are you using Kilauea or a custom 405EX board?<br>
<br>
Best regards,<br>
<font color=3D"#888888">Stefan<br>
<br>
</font></blockquote></div><br>Yes, it&#39;s the Kilauea board. <br>

--001636c5a345486bfe046cee37bd--
