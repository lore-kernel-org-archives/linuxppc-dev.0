Return-Path: <cavok@tiscali.it>
Received: from filibusta.crema.unimi.it (filibusta.crema.unimi.it
	[159.149.70.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "filibusta.crema.unimi.it",
	Issuer "filibusta.crema.unimi.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29AC667A60
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 07:54:06 +1000 (EST)
Date: Mon, 10 Apr 2006 23:54:28 +0200
From: Domenico Andreoli <cavokz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060410215428.GA22290@raptus.dandreoli.com>
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
	<20060406221056.GA15540@raptus.dandreoli.com>
	<20060408082100.GA54030@server.idefix.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060408082100.GA54030@server.idefix.loc>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Apr 08, 2006 at 10:21:00AM +0200, Matthias Fechner wrote:
> Hello Domenico,

Hello Matthias,

> * Domenico Andreoli <cavokz@gmail.com> [07-04-06 00:10]:
> > kernel is built following the instructions on your wiki, i attached
> > the config file. please have a look, let me know if any check/test may
> > be advised.
> 
> sry, but I have now time to try your kernel config, but I attached
> mine which is working fine for me.
> Maybe this helps you.

unfortunately it does not :/

sometimes kernel prints "eth0: config: auto-negotiation on, 100HDX,
10HDX.", the eth0 is up and everything works.

most of the times "eth0: config: auto-negotiation off, No speed/duplex
selected?." is instead printed and eth0 seems to not exist.

i tend to exclude hw problems, older kernel 2.4.x always succeed in
using eth0.

is there any way to force eth0 auto-negotiation?

thank you
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
