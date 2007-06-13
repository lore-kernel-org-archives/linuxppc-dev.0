Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 298A5DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:15:38 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5D7FO7S002062
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 00:15:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5D7FN1l007118
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:15:24 -0500 (CDT)
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
References: <1181717615.9397.40.camel@localhost.localdomain>
	<6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181718898.12936.6.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 15:14:58 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-13 at 15:03, Segher Boessenkool wrote:
> > Fix the reset bug on 8548CDS board.
> 
> > Segher, do you have any comment?
> 
> This one looks fine, only some cosmetics left :-)
> 
> > If yes, I will revise again; if No, pick it up!
> 
> Well it's not me who picks things up around here...
I know, it's Paul or Kumar! I just like to hear your valuable comment...
> 
> > +                             printk (KERN_EMERG "Error: reset
> control \
> > +                                     register not mapped,
> spinning!\n");
> 
> ...(... "bla bla bla "
>         "bla bla bla\n");
> 
> instead?  Or there'll be a lot of whitespace in your string.
I just do not know the difference of these two style.
> I don't see anything spinning like the warning says, btw (or
> it must be something in abort()?)
You can find the similar thing in 83xx/mis.c
[snip]
	} else {
		printk (KERN_EMERG "Error: Restart registers not mapped,
spinning!\n");
	}
[snip]
Roy
