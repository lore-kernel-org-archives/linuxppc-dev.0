Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id B69E9DE195
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 06:47:15 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1042927pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 13:47:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <48011B70.1020102@garzik.org>
References: <20080327144044.GA8831@ru.mvista.com> <47EDA6F1.9080206@garzik.org>
	<20080411092417.57825115@zod.rchland.ibm.com>
	<48011B70.1020102@garzik.org>
Content-Type: text/plain
Date: Sat, 12 Apr 2008 15:47:10 -0500
Message-Id: <1208033230.5869.18.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-12 at 16:28 -0400, Jeff Garzik wrote:
> Josh Boyer wrote:
> > On Fri, 28 Mar 2008 22:18:25 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> > 
> >> Valentine Barshak wrote:
> >>> The PowerPC 440GX Taishan board fails to reset EMAC3 (reset timeout error)
> >>> if there's no link. Because of that it fails to find PHY chip. The older ibm_emac
> >>> driver had a workaround for that: the EMAC_CLK_INTERNAL/EMAC_CLK_EXTERNAL macros,
> >>> which toggle the Ethernet Clock Select bit in the SDR0_MFR register. This patch
> >>> does the same for "ibm,emac-440gx" compatible chips. The workaround forces
> >>> clock on -all- EMACs, so we select clock under global emac_phy_map_lock.
> >>>
> >>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> >>> ---
> >>>  drivers/net/ibm_newemac/core.c |   16 +++++++++++++++-
> >>>  drivers/net/ibm_newemac/core.h |    8 ++++++--
> >>>  2 files changed, 21 insertions(+), 3 deletions(-)
> >> is this for 2.6.25-rc?
> > 
> > Jeff, can I get an ack from you on this patch, and patch 2 in this
> > set?  They depend on a patch in my tree and I'd like to include them in
> > my next push to Paul for 2.6.26.
> 
> ACK

Many thanks.

> I had queried the status of these patches, and didn't receive any reply 
> initially from my query...

Erm...  you did.

http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053737.html

No worries though.  I lose email all the time.

josh
