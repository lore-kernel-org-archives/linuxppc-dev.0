Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81D8DDDED4
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:55:16 +1100 (EST)
Message-ID: <47CC73CE.4080801@freescale.com>
Date: Mon, 03 Mar 2008 15:55:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
In-Reply-To: <20080303212622.GB20382@netgate.macqel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Philippe De Muyter wrote:
> The following seems important also :
> 
> /*
>                 interrupts = <18 2>;
> */
>                 /* interrupts number are coded in hexa ! */
>                 interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;
> 
> I have replaced the interrupts spec in comments by the longer interrupts spec
> below,

Why?

> and it seems to have some positive effect,

What kind of positive effect?  I'd think the extra interrupts would just 
be ignored.  The interrupts property for the PCI node itself is 
generally for error reporting.

> I know that 25, 26, 27, 53, 54 and 55 decimal i(hence 19, 1a etc...) are the
> interrupts numbers that I had in the ARCH=ppc version.  I added 18 because
> of the error message, but it did not help.

What ARCH=ppc version?  There are no device trees for non-OF boards in 
arch/ppc.

-Scott
