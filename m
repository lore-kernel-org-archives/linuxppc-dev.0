Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFC48DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 18:08:02 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5D87qmu004084
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:07:52 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5D87nmM007505
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 03:07:50 -0500 (CDT)
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4470838fec2256a98e512486f8486605@kernel.crashing.org>
References: <989B956029373F45A0B8AF0297081890D2AC84@zch01exm26.fsl.freescale.net>
	<4470838fec2256a98e512486f8486605@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1181722043.13195.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jun 2007 16:07:23 +0800
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

On Wed, 2007-06-13 at 15:55, Segher Boessenkool wrote:
> > It will be good if you do:
> > +                             printk (KERN_EMERG "Error: reset
> > control"
> > +                                     "register not mapped,
> > spinning!\n");
> >
> > Instead of:
> > +                             printk (KERN_EMERG "Error: reset
> control
> > \
> > +                                     register not mapped,
> > spinning!\n");
> 
> Except you forgot a space.  Too much whitespace in the
> resulting string is bad, but too little doesn't help
> either ;-)
I noticed that space, except that I am not sure the difference between \
and ".
I decided to leave it as two line with " not \.
Thanks
Roy
