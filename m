Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gMDd07fLzF1C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 15:24:17 +1000 (AEST)
In-Reply-To: <AM5PR03MB28499BE4A0B6200F7DA83835C92B0@AM5PR03MB2849.eurprd03.prod.outlook.com>
To: Alexey Spirkov <AlexeiS@astrosoft.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "andrew@ncrmnt.org" <andrew@ncrmnt.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: Adds __init annotation at mmu_init_secondary func
Message-Id: <41gMDc2g70z9sCQ@ozlabs.org>
Date: Wed,  1 Aug 2018 15:24:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-26 at 12:52:50 UTC, Alexey Spirkov wrote:
> mmu_init_secondary function called at initialization sequence
> but it misses __init annotation. As result modpost warning is generated.
> Some building systems sensitive to such kind of warnings.
> 
> Signed-off-by: Alexey Spirkov <alexeis@astrosoft.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f7e2a152231f4a0308cc8f9c2296ba

cheers
