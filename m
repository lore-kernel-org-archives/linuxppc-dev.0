Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B506CDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 02:59:06 +1100 (EST)
Date: Wed, 14 Mar 2007 10:59:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070314155900.GA10075@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<17911.31029.598986.827186@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17911.31029.598986.827186@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 03:25:25PM +1100, Paul Mackerras wrote:
> Hmmm... is ppcboot.h a direct copy of a file from somewhere else
> (e.g. uboot), or did you construct it?  It has an *awful* lot of
> ifdefs.  If it is a direct copy from uboot, I can see an argument for
> keeping it as-is, but if not, I think we can come up with a better way
> to structure things.

It's copied from asm-ppc/ppcboot.h, which was presumably copied from
u-boot/ppcboot at some point.  It's certainly ugly, but changing it would
break compatibility (thus negating the point of cuImage).

-Scott
