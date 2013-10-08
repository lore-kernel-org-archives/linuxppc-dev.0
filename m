Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A59132C007B
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Oct 2013 08:50:54 +1100 (EST)
Date: Tue, 8 Oct 2013 23:44:06 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Kind of revert "powerpc: 52xx: provide a default in
 mpc52xx_irqhost_map()"
Message-ID: <20131008234406.38cbebe2@crub>
In-Reply-To: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
References: <1380901029-3548-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  4 Oct 2013 17:37:09 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> This more or less reverts commit 6391f697d4892a6f233501beea553e13f7745a23.
> Instead of adding an unneeded 'default', mark the variable to prevent
> the false positive 'uninitialized var'. The other change (fixing the
> printout) needs revert, too. We want to know WHICH critical irq failed,
> not which level it had.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>

applied, thanks!
