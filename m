Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A499A1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:46:38 +1100 (AEDT)
In-Reply-To: <1449614642-8161-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: sbc8641: drop bogus PHY IRQ entries from DTS file
Message-Id: <20151214094638.87145140557@ozlabs.org>
Date: Mon, 14 Dec 2015 20:46:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-12 at 22:44:02 UTC, Paul Gortmaker wrote:
> This file was originally cloned off of the MPC8641D-HPCN reference
> platform, which actually had a PHY IRQ line connected.  However
> this board does not.  The bogus entry was largely inert and went
> undetected until commit 321beec5047af83db90c88114b7e664b156f49fe
> ("net: phy: Use interrupts when available in NOLINK state") was
> added to the tree.
> 
> With the above commit, the board fails to NFS boot since it sits
> waiting for a PHY IRQ event that of course never arrives.  Removing
> the bogus entries from the DTS file fixes the issue.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5b01310cfc8d2302dcca1d8d

cheers
