Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C8C21679EA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 04:56:07 +1000 (EST)
Date: Fri, 14 Apr 2006 13:55:46 -0500
To: paulus@samba.org
Subject: Re: [PATCH] [1/2] POWERPC: IOMMU support for honoring dma_mask
Message-ID: <20060414185546.GA24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060413020559.GC24769@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, plush@optonline.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 09:05:59PM -0500, Olof Johansson wrote:

> Since time is somewhat of essense (if 2.6.17 is still an option), I went
> for the choice of sending now and follow up with a small bugfix later
> in case something shows up, especially since quick regression tests seem
> ok.

FYI, I now have a positive test report from a bcm43xx user with a 1.5GB G5.
(Thanks for testing this, Marc!).


-Olof
