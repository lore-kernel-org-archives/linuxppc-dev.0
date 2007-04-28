Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C059DDF3A
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 01:30:56 +1000 (EST)
Message-ID: <4633689E.50900@garzik.org>
Date: Sat, 28 Apr 2007 11:30:38 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>,  paulus@samba.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] Rename get_property to of_get_property: drivers/net
References: <20070427145107.4f73e436.sfr@canb.auug.org.au>
	<20070427145508.9c5641a2.sfr@canb.auug.org.au>
In-Reply-To: <20070427145508.9c5641a2.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> This is part of the consolidation of the OpenFirmware code ebtween
> PowerPC and Sparc.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/bmac.c           |    5 +++--
>  drivers/net/ehea/ehea_main.c |    6 +++---
>  drivers/net/mace.c           |    4 ++--
>  drivers/net/pasemi_mac.c     |    2 +-
>  drivers/net/spider_net.c     |    4 ++--
>  drivers/net/sungem.c         |    2 +-
>  drivers/net/sungem_phy.c     |    2 +-
>  drivers/net/ucc_geth.c       |   18 +++++++++---------
>  drivers/net/ucc_geth_mii.c   |    4 ++--
>  9 files changed, 24 insertions(+), 23 deletions(-)
> 
> Jeff,
> 
> This patch is based on a merge between Paulus' for-2.6.22 tree and your
> upstream tree.  As such it depends on changes in Paulus' tree to be
> merged first.  This patch was originally in Paulus' tree but has been
> reverted from there.

Sorry for your being a football here.

AFAICS, looking at the two patches, it seems clear they should go in via 
Paulus's tree.  There are clear dependencies, and it is clearly 
arch-specific code.

If anything, it sounds like I should drop a ucc_geth patch or two from 
my tree.  Is that the case?

	Jeff
