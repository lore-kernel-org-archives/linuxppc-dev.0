Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EF0AF2C0295
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:29:14 +1100 (EST)
Date: Tue, 12 Mar 2013 22:29:04 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 1/1] serial/mpc52xx_uart: fix psc clock name for mpc512x
Message-ID: <20130312222904.1c7acbc8@crub>
In-Reply-To: <1363123037-4926-1-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363123037-4926-1-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matteo Facchinetti <engineering@sirius-es.it>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, 12 Mar 2013 22:17:17 +0100
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:

> From: Matteo Facchinetti <engineering@sirius-es.it>
> 
> On platform mpc512x, PSC clock name registered by clk_register()
> (clock.c:703) has _mclk suffix.
> In mpc512x uart device driver, PSC clock name has _clk suffix.
> 
> So change PSC clock name in UART device driver using registered clock.

This bug is already fixed in the tty tree [1].

Thanks,

Anatolij

[1] https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/commit/?h=tty-linus&id=09081e5b47f6842669bb645e015deedf191244f4
