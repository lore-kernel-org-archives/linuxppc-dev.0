Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id BF8E0DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 02:17:34 +1100 (EST)
Date: Thu, 15 Mar 2007 10:17:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070315151728.GA20430@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<17911.31029.598986.827186@cargo.ozlabs.ibm.com>
	<20070314155900.GA10075@ld0162-tx32.am.freescale.net>
	<20070314233627.GB12573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314233627.GB12573@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 10:36:27AM +1100, David Gibson wrote:
> On Wed, Mar 14, 2007 at 10:59:00AM -0500, Scott Wood wrote:
> > It's copied from asm-ppc/ppcboot.h, which was presumably copied from
> > u-boot/ppcboot at some point.  It's certainly ugly, but changing it would
> > break compatibility (thus negating the point of cuImage).
> 
> Presumably?  It would be nice to confirm this and see how much it
> actually resembles any current file from u-boot.

Oh, it resembles u-boot's include/asm-ppc/u-boot.h a great deal.  I just
wasn't 100% sure in which direction the copying took place.

-Scott
