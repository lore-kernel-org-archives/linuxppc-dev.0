Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0A51DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 04:48:16 +1100 (EST)
Date: Tue, 18 Mar 2008 12:48:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/8] [POWERPC] qe_lib: implement qe_muram_offset
Message-ID: <20080318174817.GC4099@loki.buserror.net>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172413.GC7727@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080311172413.GC7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 08:24:13PM +0300, Anton Vorontsov wrote:
> qe_muram_offset is the reverse of the qe_muram_addr, will be
> used for the Freescale QE USB Host Controller driver.
> 
> This patch also moves qe_muram_addr into the qe.h header, plus
> adds __iomem hints to use with sparse.

We should really switch QE over to using the muram code in cpm_common.c...

-Scott
