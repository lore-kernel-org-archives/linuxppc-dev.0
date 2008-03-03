Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43DB9DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:42:26 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080303212622.GB20382@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 08:41:33 +1100
Message-Id: <1204580493.21545.27.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Thanks
> 
> The following seems important also :
> 
> /*
>                 interrupts = <18 2>;
> */
>                 /* interrupts number are coded in hexa ! */
>                 interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;
> 
> I have replaced the interrupts spec in comments by the longer interrupts spec
> below, and it seems to have some positive effect, but I do not know
> precisely what I have described there.
> 
> I know that 25, 26, 27, 53, 54 and 55 decimal i(hence 19, 1a etc...) are the
> interrupts numbers that I had in the ARCH=ppc version.  I added 18 because
> of the error message, but it did not help.

Where is this ? (What node ?) The above looks like the interrupt spec
for a single device with 7 interrupts, is that what you are trying to
do ?

If not, then it's incorrect, you have to figure the interrupt-map out
(it's really not -that- hard).

Ben.
