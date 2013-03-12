Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C7CD22C0461
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:17:11 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2CLGt1v002377
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 16:17:08 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [PATCH 8/8] powerpc/85xx: Update corenet64_smp_defconfig for T4240
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-8-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:15:54 -0500
Message-Id: <067DBF1E-38A0-4189-8B2E-6E98020C0560@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-6-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-8-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 5:16 PM, Kumar Gala wrote:

> * Add support for up to 24 cores on T4240 (includes threads)
> * Enable AltiVec support (on T4240)
> * Add T4240QDS board into build
> * Other changes are due to general kernel update of defconfig
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/configs/corenet64_smp_defconfig |    9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)

applied to next

- k
