Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED8F62C06A7
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:17:00 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2CLGt1s002377
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 16:16:55 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [PATCH 3/8] powerpc/fsl-booke: Support detection of page sizes on
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:15:27 -0500
Message-Id: <36167A26-CF56-4378-BB8E-9F7767AE9D4A@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 5:15 PM, Kumar Gala wrote:

> The e6500 core used on T4240 and B4860 SoCs from FSL implements MMUv2 of
> the Power Book-E Architecture.  However there are some minor differences
> between it and other Book-E implementations.
> 
> Add support to parse SPRN_TLB1PS for the variable page sizes supported.
> In the future this should be expanded for more page sizes supported on
> e6500 as well as other MMU features.
> 
> This patch is based on code from Scott Wood.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/mm/tlb_nohash.c |   18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)

applied to next

- k
