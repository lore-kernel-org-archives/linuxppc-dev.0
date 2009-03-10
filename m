Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32E1DDE11E
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 05:54:04 +1100 (EST)
Message-Id: <EB50E1DE-F2B4-4FB8-B452-155241085A79@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20090310184154.535895939@linutronix.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [patch 1/1] powerpc: remove setup_irq(NULL action) in ksi8560
Date: Tue, 10 Mar 2009 13:53:16 -0500
References: <20090310184154.535895939@linutronix.de>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2009, at 1:43 PM, Thomas Gleixner wrote:

> setup_irq(0, NULL) is broken as setup_irq() dereferences action
> unconditionally.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Linux PPC Development <linuxppc-dev@ozlabs.org>
> ---
> arch/powerpc/platforms/85xx/ksi8560.c |    2 --
> 1 file changed, 2 deletions(-)

applied to next

- k
