Return-Path: <cavok@tiscali.it>
Received: from filibusta.crema.unimi.it (filibusta.crema.unimi.it
	[159.149.70.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "filibusta.crema.unimi.it",
	Issuer "filibusta.crema.unimi.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 606D467DF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 21:11:15 +1000 (EST)
Date: Thu, 13 Apr 2006 12:23:30 +0200
From: Domenico Andreoli <cavokz@gmail.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060413102330.GA10025@raptus.dandreoli.com>
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
	<20060406221056.GA15540@raptus.dandreoli.com>
	<20060408082100.GA54030@server.idefix.loc>
	<20060410215428.GA22290@raptus.dandreoli.com>
	<443D7F78.30402@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <443D7F78.30402@246tNt.com>
Cc: massimo.vanetti@fastwebnet.it, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2006 at 12:30:16AM +0200, Sylvain Munaut wrote:
> Domenico Andreoli wrote:
> >
> > sometimes kernel prints "eth0: config: auto-negotiation on, 100HDX,
> > 10HDX.", the eth0 is up and everything works.
> >
> > most of the times "eth0: config: auto-negotiation off, No speed/duplex
> > selected?." is instead printed and eth0 seems to not exist.
> >
> > i tend to exclude hw problems, older kernel 2.4.x always succeed in
> > using eth0.
> >
> > is there any way to force eth0 auto-negotiation?
> >   
> When it doesn't work, did it detect the phy correctly ?
> Somewhere in the boot sequence it should print something about a LXT971
> being found at some address.

no, it does not, it uses GENERIC. when PHY is detected as LXT971,
network works.

actually this is unrelated with previous runs of kernel 2.4 (as i
stated in some previous post). sometimes PHY is detected correctly,
sometimes is not.

thank you
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
