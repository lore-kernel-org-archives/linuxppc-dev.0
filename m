Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8E4122C0107
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 02:10:54 +1100 (EST)
Subject: Re: [PATCH 02/17] powerpc/85xx: do not sync time base at boot time
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364994565-16010-2-git-send-email-chenhui.zhao@freescale.com>
Date: Wed, 3 Apr 2013 10:10:58 -0500
Message-Id: <E5707E1B-20F9-495B-A83C-E115CDCEF4BE@kernel.crashing.org>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
 <1364994565-16010-2-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 3, 2013, at 8:09 AM, Zhao Chenhui wrote:

> From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
>=20
> The bootloader have done time base sync for all cores, so skip
> the synchronization process at boot time of kernel.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    8 ++++++++
> 1 files changed, 8 insertions(+), 0 deletions(-)

What harm is there in doing the sync?  I'm sure there is another reason =
you want to skip the TB sync that should be conveyed in the commit =
message.

- k=
