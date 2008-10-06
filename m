Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AFD0EDDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 08:32:11 +1100 (EST)
Date: Tue, 7 Oct 2008 01:32:09 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20081006213209.GA13072@oksana.dev.rtsoft.ru>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EA77EF.6080502@genesi-usa.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
> There is a simple problem with the patch which is that an "IRQ 0" can and does
> actually exist on a bunch of platforms, at least to the best of my knowledge.
> 
> Checking for -1 (which means for definite, no irq at all, because it is
> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.

This was discussed years ago.

http://lkml.org/lkml/2005/11/22/159
http://lkml.org/lkml/2005/11/22/227

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
