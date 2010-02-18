Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E73A3B7CF6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 09:01:34 +1100 (EST)
Subject: Re: [PATCH] powerpc/86xx: Convert gef_pic_lock to raw_spinlock
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100218135727.GA18924@oksana.dev.rtsoft.ru>
Date: Thu, 18 Feb 2010 16:01:25 -0600
Message-Id: <BBED50BD-6A31-4AD0-8642-A527426CC08B@kernel.crashing.org>
References: <20100218121904.620984825@linutronix.de>
	<20100218135727.GA18924@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 18, 2010, at 7:57 AM, Anton Vorontsov wrote:

> Interrupt controllers' hooks are executed in the atomic context, so
> they are not permitted to sleep (with RT kernels non-raw spinlocks are
> sleepable). So, gef_pic_lock has to be a real (non-sleepable) spinlock.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/86xx/gef_pic.c |   14 +++++++-------
> 1 files changed, 7 insertions(+), 7 deletions(-)

applied to next

- k
