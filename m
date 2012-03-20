Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA83DB6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 03:28:47 +1100 (EST)
Date: Tue, 20 Mar 2012 17:28:43 +0100
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mpc52xx: setup port_config and CDM settings
 through DT
Message-ID: <20120320172843.30d622e6@wker>
In-Reply-To: <1332147082-4363-1-git-send-email-agust@denx.de>
References: <1303193045-20111-1-git-send-email-hs@denx.de>
 <1332147082-4363-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Heiko Schocher <hs@denx.de>, Grant Likely <glikely@secretlab.ca>,
 Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2012 09:51:22 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> From: Heiko Schocher <hs@denx.de>
> 
> If firmware does not setup the "GPS Port Configuration Register"
> and the "CDM 48MHz Fractional Divider Configuration Register",
> it can be corrected by additional properties in the device tree.
> Add appropriate code to utility functions and document used
> bindings.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: devicetree-discuss@lists.ozlabs.org
> cc: linuxppc-dev@lists.ozlabs.org
> cc: Grant Likely <glikely@secretlab.ca>
> cc: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   17 ++++++++++++
>  arch/powerpc/platforms/52xx/mpc52xx_common.c       |   27 ++++++++++++++++++++
>  2 files changed, 44 insertions(+), 0 deletions(-)

Applied for mpc5xxx next, thanks.

Anatolij
