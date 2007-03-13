Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BC7AEDDE46
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 02:43:27 +1100 (EST)
Date: Tue, 13 Mar 2007 09:43:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070313154306.GE3476@ld0162-tx32.am.freescale.net>
References: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
	<17910.4629.587851.80369@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17910.4629.587851.80369@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 01:53:09PM +1100, Paul Mackerras wrote:
> It looks to me like we should at least make the platform code provide
> udelay (or mdelay), possibly with the aid of a helper function. 

As an interim measure (and/or to make the helper function more
universally usable), what about explicitly using mfspr in util.S instead
of mftb/mftbu?  Are there any chips that this won't work on?

-Scott
