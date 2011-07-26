Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id B96B7B708F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 14:52:47 +1000 (EST)
Date: Tue, 26 Jul 2011 06:52:37 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 2/4] powerpc, mpc52xx: add a4m072 board support
In-reply-to: <1308739150-31527-1-git-send-email-hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Message-id: <4E2E4815.5050504@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1308729311-15375-3-git-send-email-hs@denx.de>
	<1308739150-31527-1-git-send-email-hs@denx.de>
Cc: devicetree-discuss@ozlabs.org, Wolfgang Denk <wd@denx.de>
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
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: devicetree-discuss@ozlabs.org
> cc: Wolfgang Denk <wd@denx.de>
> cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
> For this patchseries following patch is needed:
> 
> http://patchwork.ozlabs.org/patch/91919/
> 
> Grant? Do you have some comments on that patch?
> 
> changes for v2:
>   add comment from Wolfram Sang:
>   use mpc5200.dtsi
> 
>  arch/powerpc/boot/dts/a4m072.dts             |  172 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 173 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/a4m072.dts

Are there some more comments or is this ready for going
to mainline?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
