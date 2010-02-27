Return-Path: <pppeterpppan@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by ozlabs.org (Postfix) with ESMTP id 4A50EB7D65
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 12:12:07 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 5so140707qwf.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 17:12:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100226183559.GA17941@loki.buserror.net>
References: <48abf2c21002251808v4d40ea42s869b1307dfc3817@mail.gmail.com>
	<20100226183559.GA17941@loki.buserror.net>
Date: Sat, 27 Feb 2010 09:12:05 +0800
Message-ID: <48abf2c21002261712m2ca34388g7e95dce346e87cfc@mail.gmail.com>
Subject: Re: Does Linux 2.6.32 support NAND flash connect with MPC8247 through
	localbus with GPCM mode?
From: Peter Pan <pppeterpppan@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/2/27 Scott Wood <scottwood@freescale.com>:
> On Fri, Feb 26, 2010 at 10:08:09AM +0800, Peter Pan wrote:
> There isn't one. =A0I was not under the impression that such a configurat=
ion
> was even possible (how do you control ALE/CLE, for example?). =A0There is=
 a
> NAND driver that uses UPM, though -- perhaps you could use that?
>
> How specifically is NAND connected to the SoC on your board? =A0What abou=
t it
> suggests GPCM?
>
> -Scott
>
Our custom board is originally running VxWorks, and there is a full
solution on NAND
flash connected through GPCM. Because of this, our Linux can only try
to adapt to this.

I'm now writing GPCM NAND driver from the UPM NAND driver. Most function ca=
n be
copied from our U-Boot port. Now the NAND flash can be recognized, but ther=
e is
some bug in my driver, the kernel will oops for access 0x00000000, I
will continue
writing the driver next monday.
