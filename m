Return-Path: <rscop@matrix.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id 433DD67BD9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 09:09:11 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	10.03.3304/NU1492.00.9f6ce814) with ESMTP id sduspbaa for
	linuxppc-embedded@ozlabs.org; Thu, 30 Jun 2005 20:14:01 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <rscop@matrix.com.br>
To: "Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com>, <markc@mail.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Thu, 30 Jun 2005 20:15:53 -0300
References: <s2c4339f.015@scms1.sc.signaal.nl>
In-Reply-To: <s2c4339f.015@scms1.sc.signaal.nl>
MIME-Version: 1.0
Message-Id: <200506302015.53594.rscop@matrix.com.br>
Subject: Re: eth0 autonegotation 8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Samuel

On Thursday 30 June 2005 13:01, Samuel Osorio Calvo wrote:
> First of all , thanks to all who replied,
>
> It is definetely related to interrupts since starting the target withou=
t
> the eth wire plugged enables me to login into the board. Of course, wit=
hout
> network connectivity......and whenever the wire is connected ->the boar=
d
> freezes again (no message, no panic, nothing....).
Well, some fcc-related interrupt is problably ocurring, then. You should=20
attach a BDI2000 to continue debugging, or at least put some printk in=20
fcc_enet code to see which interrupts are ocurring and what happens then.

>
> The boot process seems everything ok,  the request_irq returns ok for b=
oth
> the mii and the fcc. I am not using a commercial board and some tuning =
were
> made to the kernel to adjust to the hardware configuration, mainly cloc=
ks
> and MDIO pins. I took changes somebody made with DENX's 2.4.18 and port=
ed
> them to 2.4.25, probably forgeting something in the way....may be somet=
hing
> related to interrupts interfaces has changed since then???
Yes, many things may have happened, but we don't know what because we don=
't=20
have your ported code...

HTH,

-Scop.

=2Eo.
=2E.o
ooo (http://www.catb.org/hacker-emblem/)
