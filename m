Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F14BEB7CCD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:18:45 +1100 (EST)
Subject: Re: [PATCH 3/5] powerpc/head fsl: replace a hardcoded constant
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263573697-17839-4-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Date: Wed, 17 Feb 2010 21:11:14 -0600
Message-Id: <EACE01D1-B8EF-4D59-BAAB-CF133803261D@kernel.crashing.org>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<1263573697-17839-4-git-send-email-linuxppc-dev@ml.breakpoint.cc>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> 24 is offset between the opcode past bl and past rfi. This makes it more
> obvious.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to next

- k
