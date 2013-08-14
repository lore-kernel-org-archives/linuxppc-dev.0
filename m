Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id 8FE3A2C010B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 02:15:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id B11E212B0DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 18:15:24 +0200 (CEST)
Date: Wed, 14 Aug 2013 18:15:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 1/3] powerpc: Add iommu domain pointer to device archdata
Message-ID: <20130814161522.GP28811@8bytes.org>
References: <1373863857-27239-1-git-send-email-Varun.Sethi@freescale.com>
 <20130814094802.GC4491@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D0A42CDB5@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D0A42CDB5@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 14, 2013 at 09:56:11AM +0000, Sethi Varun-B16395 wrote:
> Please find the .config file attached with this mail.

Fantastic, thanks. The build works fine, I'll include the driver into my
next-branch. I also have two minor clean-up patches on-top, just if you
where wondering.


	Joerg
