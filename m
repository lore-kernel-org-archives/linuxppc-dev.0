Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BB921DDE99
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Feb 2008 03:11:24 +1100 (EST)
Message-ID: <47ADD0A6.4090501@grandegger.com>
Date: Sat, 09 Feb 2008 17:11:18 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: rakesh bk <rakeshbk402@gmail.com>
Subject: Re: porting xenomaii for power pc 750Cxe based SBC
References: <43455a600802070411w42b6745aqf87fa3ae88dcaf8c@mail.gmail.com>
In-Reply-To: <43455a600802070411w42b6745aqf87fa3ae88dcaf8c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

rakesh bk wrote:
> Hello Everyone,
> 
> Iam Trying to port the xenomai-2.2.0 using the
> "adeos-ipipe-2.6.14-ppc-1.3-05.patch"  to linux-kernel 2.6.14( Vanilla)
> to our custom based SBC, After applying patches as i get Enough printk's
> on my console , I get Stucked after UNMASKING of Ethernet Irq The
> following are the printk messages after i tried to boot the image. can i
> know what the actual problem is ...........

This mail is off topic. Please repost on the Xenomai-help mailing list
(https://gna.org/mail/?group=xenomai). As you can see from your boot
log, already the Xenomai initialization fails.

Wolfgang.
