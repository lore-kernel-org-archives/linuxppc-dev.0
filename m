Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48623B7CC2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 03:32:54 +1100 (EST)
Date: Thu, 18 Feb 2010 17:32:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc/qe: Convert qe_ic_lock to raw_spinlock
In-Reply-To: <20100218134312.GA5331@oksana.dev.rtsoft.ru>
Message-ID: <alpine.LFD.2.00.1002181732220.2811@localhost.localdomain>
References: <20100218121904.620984825@linutronix.de>
	<20100218134312.GA5331@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thu, 18 Feb 2010, Anton Vorontsov wrote:

> Interrupt controllers' hooks are executed in the atomic context, so
> they are not permitted to sleep (with RT kernels non-raw spinlocks are
> sleepable). So, qe_ic_lock has to be a real (non-sleepable) spinlock.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
