Return-Path: <sasha.levin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrWDk3X09zDqyT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 21:53:42 +1000 (AEST)
Subject: Re: [4.1.28 PATCH] powerpc: Fix build break due to missing
 PPC_FEATURE2_HTM_NOSC
To: Michael Ellerman <mpe@ellerman.id.au>
References: <87bn20a30y.fsf@@concordia.ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@bayern-mail.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>, stable@vger.kernel.org
From: Sasha Levin <sasha.levin@oracle.com>
Message-ID: <5788CEB9.4020101@oracle.com>
Date: Fri, 15 Jul 2016 07:53:29 -0400
MIME-Version: 1.0
In-Reply-To: <87bn20a30y.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/14/2016 07:10 AM, Michael Ellerman wrote:
> The backport of 4705e02498d6 ("powerpc: Update TM user feature bits in
> scan_features()") (f49eb503f0f9), missed the fact that 4.1 doesn't
> include the commit that added PPC_FEATURE2_HTM_NOSC.
> 
> The correct fix is simply to omit PPC_FEATURE2_HTM_NOSC.
> 
> Fixes: f49eb503f0f9 ("powerpc: Update TM user feature bits in scan_features()")
> Reported-by: Christian Zigotzky <chzigotzky@bayern-mail.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks Michael, I've queued it up.


Thanks,
Sasha
