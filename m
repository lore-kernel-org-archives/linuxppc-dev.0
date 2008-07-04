Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C199DDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 00:32:54 +1000 (EST)
Message-Id: <A2A80C78-AF10-4FC0-A7E7-CDCACA9AD7E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080703232001.GB9594@localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] Add PPC_FEATURE_PMU_COMPAT
Date: Fri, 4 Jul 2008 09:32:45 -0500
References: <20080703232001.GB9594@localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 6:20 PM, Nathan Lynch wrote:

> Beginning with Power6, there is a set of 32 PMU events which is
> compatible across POWER processor lines.  PPC_FEATURE_PMU_COMPAT
> indicates support for this subset.
>
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> ---
> arch/powerpc/kernel/cputable.c |    4 ++--
> include/asm-powerpc/cputable.h |    1 +
> 2 files changed, 3 insertions(+), 2 deletions(-)

Can you explain what these PMU events are a bit further?

- k
