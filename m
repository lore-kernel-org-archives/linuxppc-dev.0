Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 171DBB7D88
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 08:52:47 +1100 (EST)
Subject: Re: [patch 06/15] powerpc: Convert tlbivax_lock to raw_spinlock
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100218122000.354221871@linutronix.de>
Date: Thu, 18 Feb 2010 15:52:28 -0600
Message-Id: <361AD6E8-9935-426E-8B48-1F44175D824F@kernel.crashing.org>
References: <20100218121904.620984825@linutronix.de>
	<20100218122000.354221871@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 18, 2010, at 6:22 AM, Thomas Gleixner wrote:

> tlbivax_lock needs to be a real spinlock in RT. Convert it to
> raw_spinlock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/powerpc/mm/tlb_nohash.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
