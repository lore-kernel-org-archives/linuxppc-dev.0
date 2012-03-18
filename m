Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6E836B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:13:59 +1100 (EST)
Date: Sun, 18 Mar 2012 22:13:50 +0100
From: Anatolij Gustschin <agust@denx.de>
To: hs@denx.de
Subject: Re: [PATCH 1/4] net, phy: am79c874 support
Message-ID: <20120318221350.15588f57@wker>
In-Reply-To: <4E2E48A8.6070108@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
 <1308729311-15375-2-git-send-email-hs@denx.de>
 <4E2E48A8.6070108@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Heiko,

On Tue, 26 Jul 2011 06:55:04 +0200
Heiko Schocher <hs@denx.de> wrote:

> Hello,
> 
> Heiko Schocher wrote:
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > cc: linux-netdev@vger.kernel.org
> > cc: Wolfgang Denk <wd@denx.de>
> > ---
> >  drivers/net/phy/Kconfig  |    5 ++
> >  drivers/net/phy/Makefile |    1 +
> >  drivers/net/phy/amd79.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/net/phy/amd79.c
> 
> Are there some more comments or is this patch ready for going
> to mainline?

This patch is not ready yet and it seems it didn't reach the netdev
list, probably because of wrong netdev address. I reworked it a bit
and have sent a new version to the netdev list.

Thanks,
Anatolij
