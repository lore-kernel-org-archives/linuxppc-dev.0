Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id B5B1CB702E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 14:55:08 +1000 (EST)
Date: Tue, 26 Jul 2011 06:55:04 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/4] net, phy: am79c874 support
In-reply-to: <1308729311-15375-2-git-send-email-hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Message-id: <4E2E48A8.6070108@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1308729311-15375-1-git-send-email-hs@denx.de>
	<1308729311-15375-2-git-send-email-hs@denx.de>
Cc: linux-netdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: linux-netdev@vger.kernel.org
> cc: Wolfgang Denk <wd@denx.de>
> ---
>  drivers/net/phy/Kconfig  |    5 ++
>  drivers/net/phy/Makefile |    1 +
>  drivers/net/phy/amd79.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/phy/amd79.c

Are there some more comments or is this patch ready for going
to mainline?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
