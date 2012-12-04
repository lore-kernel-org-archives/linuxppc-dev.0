Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D29542C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 23:29:41 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 4 Dec 2012 12:29:29 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7081C2466@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
 <50BD056F.7070701@freescale.com>
 <C5ECD7A89D1DC44195F34B25E172658D2B715D@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D2B715D@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sethi Varun-B16395 wrote:

> This would in any case change with the new LIODN allocation scheme. I
> intend on introducing the new scheme as a separate patch.

At the very least, you should detect when an LIODN is too large and print=20
an error message.

--=20
Timur Tabi
Linux kernel developer at Freescale=
