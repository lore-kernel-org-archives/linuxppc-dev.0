Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6BCCDDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 18:14:38 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5D8EXcO014630
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:14:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5D8EWmw009193
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 03:14:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 16:16:24 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AC92@zch01exm26.fsl.freescale.net>
In-Reply-To: <1181722043.13195.2.camel@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
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

> -----Original Message-----
> From: Zang Roy-r61911 [mailto:tie-fei.zang@freescale.com]
> Sent: Wednesday, June 13, 2007 4:07 PM
> To: Segher Boessenkool
> Cc: Li Yang-r58472; linuxppc-dev list; Paul Mackerras
> Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
>=20
> On Wed, 2007-06-13 at 15:55, Segher Boessenkool wrote:
> > > It will be good if you do:
> > > +                             printk (KERN_EMERG "Error: reset
> > > control"
> > > +                                     "register not mapped,
> > > spinning!\n");
> > >
> > > Instead of:
> > > +                             printk (KERN_EMERG "Error: reset
> > control
> > > \
> > > +                                     register not mapped,
> > > spinning!\n");
> >
> > Except you forgot a space.  Too much whitespace in the
> > resulting string is bad, but too little doesn't help
> > either ;-)
> I noticed that space, except that I am not sure the difference between
\
> and ".
The difference is that you will get all the indentation in the next line
into the string if you use \. :-)
The output will be "Error: reset control<tab><tab><tab><tab> register
not mapped, spinning!\n"

- Leo
