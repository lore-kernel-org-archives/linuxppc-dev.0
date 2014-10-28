Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB37A1A0229
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 05:41:43 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F0B36140077
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2014 05:41:41 +1100 (AEDT)
Message-ID: <1414519738.23458.84.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@codeaurora.org>
Date: Tue, 28 Oct 2014 13:08:58 -0500
In-Reply-To: <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, Emil Medve <Emilian.Medve@freescale.com>,
 linuxppc-dev@ozlabs.org, robh+dt@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 09:36 -0500, Kumar Gala wrote:
> On Oct 22, 2014, at 9:09 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> 
> > The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
> > BMan supports hardware allocation and deallocation of buffers belonging to
> > pools originally created by software with configurable depletion thresholds.
> > This binding covers the CCSR space programming model
> > 
> > Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> > Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
> > ---
> > .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 ++++++++++++++++++++++
> > 1 file changed, 98 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> 
> Should these really be in bindings/powerpc/fsl, aren’t you guys using this on ARM SoCs as well?

The hardware on the ARM SoCs is different enough that I'm not sure the
same binding will cover it.  That said, putting things under <arch>
should be a last resort if nowhere else fits.

-Scott
