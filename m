Return-Path: <B04825@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A23892C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 09:58:56 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 4/4 v6] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Sat, 1 Dec 2012 22:58:20 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7081BD418@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1354360921-20850-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Varun Sethi wrote:
> Following is a brief description of the PAMU hardware:
> PAMU determines what action to take and whether to authorize the action o=
n
> the basis of the memory address, a Logical IO Device Number (LIODN), and
> PAACT table (logically) indexed by LIODN and address. Hardware devices wh=
ich
> need to access memory must provide an LIODN in addition to the memory add=
ress.
>
> Peripheral Access Authorization and Control Tables (PAACTs) are the prima=
ry
> data structures used by PAMU. A PAACT is a table of peripheral access
> authorization and control entries (PAACE).Each PAACE defines the range of
> I/O bus address space that is accessible by the LIOD and the associated a=
ccess
> capabilities.
>
> There are two types of PAACTs: primary PAACT (PPAACT) and secondary PAACT
> (SPAACT).A given physical I/O device may be able to act as one or more
> independent logical I/O devices (LIODs). Each such logical I/O device is
> assigned an identifier called logical I/O device number (LIODN). A LIODN =
is
> allocated a contiguous portion of the I/O bus address space called the DS=
A window
> for performing DSA operations. The DSA window may optionally be divided i=
nto
> multiple sub-windows, each of which may be used to map to a region in sys=
tem
> storage space. The first sub-window is referred to as the primary sub-win=
dow
> and the remaining are called secondary sub-windows.
>
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding IO=
MMU
> API implementation (fsl_pamu_domain.c). The PAMU hardware driver (fsl_pam=
u.c)
> has been derived from the work done by Ashish Kalra and Timur Tabi
> (timur@freescale.com).
>
> Signed-off-by: Timur Tabi<timur@freescale.com>
> Signed-off-by: Varun Sethi<Varun.Sethi@freescale.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>


--=20
Timur Tabi
Linux kernel developer at Freescale=
