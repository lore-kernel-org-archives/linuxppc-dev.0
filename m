Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id 58F872C0080
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2013 20:51:40 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 7D53E12AF4A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2013 10:51:34 +0100 (CET)
Date: Sun, 6 Jan 2013 10:51:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Message-ID: <20130106095133.GE25591@8bytes.org>
References: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
 <C5ECD7A89D1DC44195F34B25E172658D2F58B0@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D2F58B0@039-SN2MPN1-013.039d.mgd.msft.net>
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

Hi Varun,

On Thu, Jan 03, 2013 at 05:21:09AM +0000, Sethi Varun-B16395 wrote:
> It's been a while since I submitted this patch. I have tried to
> address your comments regarding the subwindow attribute. I would
> really appreciate if I can get some feedback on this patch.

I have some ideas in mind how we can abstract this in the IOMMU-API
(with an extension to the API). I will send a RFC patchset soon to add
these changes and then we can discuss it.


	Joerg
