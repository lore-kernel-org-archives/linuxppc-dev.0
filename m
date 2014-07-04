Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13A781A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 12:34:20 +1000 (EST)
Message-ID: <1404441258.25056.1.camel@concordia>
Subject: Re: [PATCH 2/3] powerpc/perf: Add PPMU_ARCH_207S define
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>
Date: Fri, 04 Jul 2014 12:34:18 +1000
In-Reply-To: <1404367956-19515-3-git-send-email-joel@jms.id.au>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
 <1404367956-19515-3-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-03 at 15:42 +0930, Joel Stanley wrote:
> Instead of separate bits for every POWER8 PMU feature, have a single one
> for v2.07 of the architecture.
> 
> This saves us adding a MMCR2 define for a future patch.

Cc: stable@vger.kernel.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
