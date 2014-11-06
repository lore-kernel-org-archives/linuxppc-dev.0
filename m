Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E16361A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 08:49:50 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64E831400A0
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2014 08:49:49 +1100 (AEDT)
Message-ID: <1415310579.23458.402.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 6 Nov 2014 15:49:39 -0600
In-Reply-To: <1415200734-6978-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1415200734-6978-1-git-send-email-Emilian.Medve@Freescale.com>
 <1415200734-6978-2-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-05 at 09:18 -0600, Emil Medve wrote:
> +Devices connected to a BMan instance via Direct Connect Portals (DCP) must link
> +to the respective BMan instance
> +
> +- fsl,bman
> +	Usage:		Required
> +	Value type:	<prop-encoded-array>
> +	Description:	List of phandle and DCP index pairs, to the BMan instance
> +			to which this device is connected via the DCP

Does software need the DCP index (though for QMan there do seem to be a
few registers associated with each DCP)?  Where can I find that info in
the manual?

-Scott
