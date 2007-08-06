Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37E07DDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:02:06 +1000 (EST)
Subject: Re: [patch 08/10] Bamboo DTS
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070806045332.GA11051@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com> >
	<20070803161711.202342000@linux.vnet.ibm.com>
	<20070806045332.GA11051@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1186423283.5970.32.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 06 Aug 2007 13:01:28 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-08-05 at 23:53, David Gibson wrote:

> > + *
> > + * To build:
> > + *   dtc -I dts -O asm -o bamboo.S -b 0 bamboo.dts
> > + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 bamboo.dts
> 
> Can we ditch this "to build" boilerplate.  It's just another thing
> people frequently forget to update as they copy it from dts to dts.

That's a good idea, I think.  Especially since it is
not really accurate for u-boot with libfdt either.
I believe it that case it needs to have some extra
space reservations made for it as well.

Thanks,
jdl
