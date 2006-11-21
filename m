Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EA5E67C44
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 00:23:07 +1100 (EST)
Date: Tue, 21 Nov 2006 14:22:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Message-ID: <20061121132253.GA17530@lst.de>
References: <4554DACB.8060809@am.sony.com> <4559099A.6060805@am.sony.com>
	<17762.26999.152198.792581@cargo.ozlabs.ibm.com>
	<200611211111.12882.arnd@arndb.de>
	<Pine.LNX.4.62.0611211114220.21124@pademelon.sonytel.be>
	<17762.59947.937875.546225@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17762.59947.937875.546225@cargo.ozlabs.ibm.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 21, 2006 at 10:59:39PM +1100, Paul Mackerras wrote:
> Geert Uytterhoeven writes:
> 
> > Indeed, and since we don't like changing all of these back and forth, it would
> > be nice to have a definitive decision soon.
> 
> Put the ps3 support in arch/powerpc/platforms/ps3.  If there are
> hypervisor-specific routines, they can have a ps3pf_ prefix if you
> want.

The whole port is hypervisor-specific.  It should be called ps3hv or
sonyhv (in case the plan for more hardware that's crippled by this
hypervisor)  ps3 should be left for a bare metal port that people may
or may not do when they have time at their hands to get rid of the
HV that cripples the hardware.
