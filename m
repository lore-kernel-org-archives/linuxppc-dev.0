Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D59C22C05F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 03:47:47 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-msi: use a different locklcass for the
 cascade interrupt
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364909616-59478-1-git-send-email-bigeasy@linutronix.de>
Date: Wed, 3 Apr 2013 11:46:15 -0500
Message-Id: <1C896E29-BB65-433D-8C95-DF511281E16F@kernel.crashing.org>
References: <1364909616-59478-1-git-send-email-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 2, 2013, at 8:33 AM, Sebastian Andrzej Siewior wrote:

> lockdep thinks that it might deadlock because it grabs a lock of the
> same class while calling the generic_irq_handler(). This annotation will
> inform lockdep that it will not.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/sysdev/fsl_msi.c |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

applied to next

- k
