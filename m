Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17911.31029.598986.827186@cargo.ozlabs.ibm.com>
Date: Wed, 14 Mar 2007 15:25:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
> U-Boot, and inserts data from it into a device tree which has been
> compiled into the kernel.  This should help ease the transition to
> arch/powerpc in cases where U-Boot has not yet been updated to pass a
> device tree, or where upgrading firmware isn't practical.

Hmmm... is ppcboot.h a direct copy of a file from somewhere else
(e.g. uboot), or did you construct it?  It has an *awful* lot of
ifdefs.  If it is a direct copy from uboot, I can see an argument for
keeping it as-is, but if not, I think we can come up with a better way
to structure things.

Paul.
