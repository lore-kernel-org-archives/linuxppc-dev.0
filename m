Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 194C32C029E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 07:26:08 +1000 (EST)
Date: Thu, 27 Jun 2013 16:25:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [v2] edac/85xx: Add PCIe error interrupt edac support
Message-ID: <20130627212540.GA412@home.buserror.net>
References: <1363250473-30652-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1363250473-30652-1-git-send-email-Chunhe.Lan@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 14, 2013 at 04:41:13PM +0800, Chunhe Lan wrote:
> Adding pcie error interrupt edac support for mpc85xx, p3041, p4080,
> and p5020. The mpc85xx uses the legacy interrupt report mechanism -
> the error interrupts are reported directly to mpic. While, the p3041/
> p4080/p5020 attaches the most of error interrupts to interrupt zero.
> And report error interrupts to mpic via interrupt 0.
> 
> This patch can handle both of them.
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> 
> ---
> drivers/edac/mpc85xx_edac.c |   94 ++++++++++++++++++++++++++++++++++++------
>  drivers/edac/mpc85xx_edac.h |    5 ++
>  2 files changed, 85 insertions(+), 14 deletions(-)

This should go to Doug Thompson and the linux-edac mailing list (see
MAINTAINERS).

I'm not sure what the relevance is of the shared error mechanism of newer
chips -- isn't this driver just going to request whatever interrupt it
finds in the device tree?

-Scott
