Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id E1FEA2C0378
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 04:09:44 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 98B3D12B132
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 19:02:30 +0200 (CEST)
Date: Tue, 8 Oct 2013 19:02:28 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
Message-ID: <20131008170228.GD17455@8bytes.org>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <20130924235812.GD9302@google.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
 <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 08, 2013 at 10:47:49AM -0600, Bjorn Helgaas wrote:
> I still have no idea what an "aperture type IOMMU" is,
> other than that it is "different."

An aperture based IOMMU is basically any GART-like IOMMU which can only
remap a small window (the aperture) of the DMA address space. DMA
outside of that window is either blocked completly or passed through
untranslated.


	Joerg
