Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 12F2EDDE0C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 12:09:49 +1000 (EST)
Date: Mon, 7 May 2007 21:11:49 -0500
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 03/13] Document the sleep property.
Message-ID: <20070508021149.GE12613@lixom.net>
References: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
	<20070507182944.GB26920@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182944.GB26920@ld0162-tx32.am.freescale.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 07, 2007 at 01:29:44PM -0500, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index fc54511..966c26b 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1738,6 +1738,16 @@ platforms are moved over to use the flattened-device-tree model.
>  
>     - interrupts : On fsl,mpc83xx-pmc, this is the PMC interrupt.
>  
> +   l) Device Power Management
> +
> +   To associate a device with the corresponding bits in a power or
> +   clock disable register, a device can contain a "sleep" property.
> +
> +   The first cell of a sleep node is a phandle to the sleep controller.
> +   The remaining cells are interpreted by said controller.  In the case
> +   of an fsl,mpc83xx-pmc sleep controller, the second cell represents the
> +   bits to clear in SCCR to stop the device's clock.

The second part here is completely implementation-dependent. I don't
really see the need to document that in this global document?


-Olof
