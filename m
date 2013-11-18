Return-Path: <scottwood@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFDDF2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 06:37:42 +1100 (EST)
Message-ID: <1384803449.1403.313.camel@snotra.buserror.net>
Subject: Re: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
 matched cpu nodes
From: Scott Wood <scottwood@freescale.com>
To: Sethi Varun-B16395 <Varun.Sethi@freescale.com>
Date: Mon, 18 Nov 2013 13:37:29 -0600
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
 <1384467025.1403.210.camel@snotra.buserror.net>
 <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-14 at 21:16 -0600, Sethi Varun-B16395 wrote:
> Haiying/Scott,
> Forgot to mention this, the PAMU driver has to handle stash destination
> settings both for power and dsp cores (on B4 platform). For the dsp
> cores we would expect the physical core id (not controlled by Linux).
> To make the interface consistent, I would expect the caller (for
> iommu_set_attr) to pass the physical core id.

That sounds like you need two different interfaces.

-Scott
