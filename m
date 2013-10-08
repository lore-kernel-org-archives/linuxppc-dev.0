Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 548252C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 03:48:14 +1100 (EST)
Received: by mail-ie0-f171.google.com with SMTP id at1so19757924iec.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Oct 2013 09:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <20130924235812.GD9302@google.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 10:47:49 -0600
Message-ID: <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 3, 2013 at 11:19 PM, Bhushan Bharat-R65777
<R65777@freescale.com> wrote:

>> I don't know enough about VFIO to understand why these new interfaces are
>> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce.c and
>> vfio_iommu_type1.c but I don't know if they're comparable to the Freescale PAMU.
>> Do other VFIO IOMMU implementations support MSI?  If so, do they handle the
>> problem of mapping the MSI regions in a different way?
>
> PAMU is an aperture type of IOMMU while other are paging type, So they are completely different from what PAMU is and handle that differently.

This is not an explanation or a justification for adding new
interfaces.  I still have no idea what an "aperture type IOMMU" is,
other than that it is "different."  But I see that Alex is working on
this issue with you in a different thread, so I'm sure you guys will
sort it out.

Bjorn
