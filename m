Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECB06DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:00:43 +1100 (EST)
Date: Wed, 11 Mar 2009 08:59:46 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 08/18] powerpc: convert obsolete irq_desc_t to struct
	irq_desc
In-Reply-To: <1236737962.7086.35.camel@pasglop>
Message-ID: <alpine.LFD.2.00.0903110859150.29264@localhost.localdomain>
References: <20090311003204.592133594@linutronix.de>
	<20090311003236.263019667@linutronix.de>
	<1236737962.7086.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 11 Mar 2009, Benjamin Herrenschmidt wrote:

> On Wed, 2009-03-11 at 00:45 +0000, Thomas Gleixner wrote:
> > plain text document attachment
> > (powerpc-convert-obsolete-irq-desc-t-typedef.patch)
> > Impact: cleanup
> > 
> > Convert the last remaining users.
> 
> Ack. This would be more easily carried in my -next tree if that's ok
> with you.

Sure. Thanks,

		tglx
