Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81EA12C013C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 09:11:31 +1000 (EST)
Message-ID: <1376349080.20487.68.camel@snotra.buserror.net>
Subject: Re: powerpc: Mark low level irq handlers NO_THREAD
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 12 Aug 2013 18:11:20 -0500
In-Reply-To: <1376318939-14447-1-git-send-email-bigeasy@linutronix.de>
References: <1376318939-14447-1-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Marcelo Tosatti <marcelo@kvack.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-12 at 16:48 +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> These low level handlers cannot be threaded. Mark them NO_THREAD
> 
> Reported-by: leroy christophe <christophe.leroy@c-s.fr>
> Tested-by: leroy christophe <christophe.leroy@c-s.fr>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This patch has been posted on Feb 13, 2013 and nobody responded back then.

It went in v3.11-rc1.

-Scott
