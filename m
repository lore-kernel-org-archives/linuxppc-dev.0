Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F3432C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 08:18:14 +1000 (EST)
Date: Sat, 24 Aug 2013 00:18:10 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 14/31] dts: mpc512x: prepare for preprocessor support
Message-ID: <20130824001810.3c97f46c@crub>
In-Reply-To: <1375821851-31609-15-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-15-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:54 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> prepare C preprocessor support when processing MPC512x DTS files
> - switch from DTS syntax to CPP syntax for include specs
> - create a symlink such that DTS processing can reference includes
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/boot/dts/ac14xx.dts          |    2 +-
>  arch/powerpc/boot/dts/include/dt-bindings |    1 +
>  arch/powerpc/boot/dts/mpc5121ads.dts      |    2 +-
>  arch/powerpc/boot/dts/pdm360ng.dts        |    2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 120000 arch/powerpc/boot/dts/include/dt-bindings

Applied, thanks!

Anatolij
