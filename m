Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CEEC2B7037
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 10:25:14 +1100 (EST)
Date: Mon, 19 Mar 2012 00:25:07 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH][RFC] mpc52xx, common: setup port_config and cdm
 settings through DTS
Message-ID: <20120319002507.275d73ef@wker>
In-Reply-To: <1303193045-20111-1-git-send-email-hs@denx.de>
References: <1303193045-20111-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Heiko,

On Tue, 19 Apr 2011 08:04:05 +0200
Heiko Schocher <hs@denx.de> wrote:

> If firmware does not setup the "GPS Port Configuration Register"
> and the "CDM 48MHz Fractional Divider Configuration Register",
> it can be corrected through DTS.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: devictree-discuss@lists.ozlabs.org
> cc: linuxppc-dev@lists.ozlabs.org
> cc: Grant Likely <glikely@secretlab.ca>
> cc: Wolfgang Denk <wd@denx.de>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   16 +++++++++++
>  arch/powerpc/platforms/52xx/mpc52xx_common.c       |   27 ++++++++++++++++++++
>  2 files changed, 43 insertions(+), 0 deletions(-)

Applied slightly modified patch to mpc5xxx next.

Thanks,
Anatolij
