Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6AE2DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:05:45 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l76I5goT031282
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 14:05:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l76I5dEw258688
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 12:05:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l76I5UKJ032634
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 12:05:30 -0600
Date: Mon, 6 Aug 2007 13:05:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [patch 08/10] Bamboo DTS
Message-ID: <20070806130529.5368fe01@weaponx.rchland.ibm.com>
In-Reply-To: <1186423283.5970.32.camel@ld0161-tx32>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161711.202342000@linux.vnet.ibm.com>
	<20070806045332.GA11051@localhost.localdomain>
	<1186423283.5970.32.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 06 Aug 2007 13:01:28 -0500
Jon Loeliger <jdl@freescale.com> wrote:

> On Sun, 2007-08-05 at 23:53, David Gibson wrote:
> 
> > > + *
> > > + * To build:
> > > + *   dtc -I dts -O asm -o bamboo.S -b 0 bamboo.dts
> > > + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 bamboo.dts
> > 
> > Can we ditch this "to build" boilerplate.  It's just another thing
> > people frequently forget to update as they copy it from dts to dts.
> 
> That's a good idea, I think.  Especially since it is
> not really accurate for u-boot with libfdt either.
> I believe it that case it needs to have some extra
> space reservations made for it as well.

Yeah, will kill it.

josh
