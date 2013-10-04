Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DCC822C007B
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Oct 2013 01:38:31 +1000 (EST)
Message-ID: <524EE0F3.6020507@linutronix.de>
Date: Fri, 04 Oct 2013 17:38:27 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Kind of revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
References: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/04/2013 05:37 PM, Wolfram Sang wrote:
> This more or less reverts commit 6391f697d4892a6f233501beea553e13f7745a23.
> Instead of adding an unneeded 'default', mark the variable to prevent
> the false positive 'uninitialized var'. The other change (fixing the
> printout) needs revert, too. We want to know WHICH critical irq failed,
> not which level it had.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
