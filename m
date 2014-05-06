Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE2E01401A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 02:57:57 +1000 (EST)
Message-ID: <1399395448.15726.185.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Updated corenet-cf compatible string for
 corenet1-cf chips
From: Scott Wood <scottwood@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Date: Tue, 6 May 2014 11:57:28 -0500
In-Reply-To: <1399388176-25257-1-git-send-email-diana.craciun@freescale.com>
References: <1399388176-25257-1-git-send-email-diana.craciun@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-06 at 17:56 +0300, Diana Craciun wrote:
> From: Diana Craciun <Diana.Craciun@freescale.com>
> 
> Updated the device trees according to the corenet-cf
> binding definition.
> 
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 2 +-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 2 +-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 2 +-
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Oops, I meant to include this in the patch I sent, but forgot to squash
the two patches together. :-P

Where's p5040?

-Scott
