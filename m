Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1B78ADE7BC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:45:19 +1000 (EST)
Date: Thu, 5 Jun 2008 16:45:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] libata: fix G5 SATA broken on -rc5
Message-ID: <20080605144511.GA6562@aepfle.de>
References: <alpine.LFD.1.10.0806042018060.3473@woody.linux-foundation.org>
	<20080605112436.GA4533@aepfle.de>
	<Pine.LNX.4.64.0806051255340.28792@blonde.site>
	<20080605135444.7a1e5158@core>
	<Pine.LNX.4.64.0806051436180.5315@blonde.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0806051436180.5315@blonde.site>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, Hugh Dickins wrote:

> Fix G5 SATA irq 18: nobody cared, reported on -rc5 by Olaf Hering:
> fixlet to a57c1bade5a0ee5cd8b74502db9cbebb7f5780b2 libata-sff:
> Fix oops reported in kerneloops.org for pnp devices with no ctl
>     
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>


Tested-by: Olaf Hering <olaf@aepfle.de>
