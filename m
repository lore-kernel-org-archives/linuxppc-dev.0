Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3AAED2C039F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 23:21:10 +1000 (EST)
Subject: Re: [PATCH 3/3 v2] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1349351808-7156-4-git-send-email-b16395@freescale.com>
Date: Thu, 4 Oct 2012 08:20:25 -0500
Message-Id: <91BA7E6D-4B29-4CCF-80EB-947EBBCF51F4@kernel.crashing.org>
References: <1349351808-7156-1-git-send-email-b16395@freescale.com>
 <1349351808-7156-4-git-send-email-b16395@freescale.com>
To: "<b16395@freescale.com>" <b16395@freescale.com>
Cc: joerg.roedel@amd.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 4, 2012, at 6:56 AM, <b16395@freescale.com> =
<b16395@freescale.com> wrote:

> From: Varun Sethi <Varun.Sethi@freescale.com>
>=20
> Following is a brief description of the PAMU hardware:
> PAMU determines what action to take and whether to authorize the =
action on the basis
> of the memory address, a Logical IO Device Number (LIODN), and PAACT =
table (logically)
> indexed by LIODN and address. Hardware devices which need to access =
memory must provide
> an LIODN in addition to the memory address.
>=20
> Peripheral Access Authorization and Control Tables (PAACTs) are the =
primary data structures
> used by PAMU. A PAACT is a table of peripheral access authorization =
and control entries (PAACE).
> Each PAACE defines the range of I/O bus address space that is =
accessible by the LIOD and the
> associated access capabilities.
>=20
> There are two types of PAACTs: primary PAACT (PPAACT) and secondary =
PAACT (SPAACT). A given physical
> I/O device may be able to act as one or more independent logical I/O =
devices (LIODs). Each such
> logical I/O device is assigned an identifier called logical I/O device =
number (LIODN). A LIOD is
> allocated a contiguous portion of the I/O bus address space called the =
DSA window for performing
> DSA operations. The DSA window may optionally be divided into multiple =
sub-windows, each of which
> may be used to map to a region in system storage space. The first =
sub-window is referred to
> as the primary sub-window and the remaining are called secondary =
sub-windows.
>=20
> This patch provides the PAMU driver (fsl_pamu.c) and the corresponding =
IOMMU API implementation
> (fsl_pamu_domain.c). The PAMU hardware driver (fsl_pamu.c) has been =
derived from the work done
> by Ashish Kalra and Timur Tabi (timur@freescale.com).
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---

I'm not seeing any of the comments I made addressed.

What changed in this version?

- k=
