Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id 76D182C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 00:41:58 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 7878B12B0EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 16:41:55 +0200 (CEST)
Date: Thu, 20 Jun 2013 16:41:53 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Sethi Varun-B16395 <B16395@freescale.com>
Subject: Re: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
 archdata
Message-ID: <20130620144152.GB3589@8bytes.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
 <AC9BAE34-A9CB-4A24-A357-0AA7734CE443@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D5CB5D4@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D5CB5D4@039-SN2MPN1-011.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
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

On Thu, Jun 20, 2013 at 02:29:30PM +0000, Sethi Varun-B16395 wrote:
> Hi Joerg,
> My PAMU driver patches depend on this patch which was Ack by Kumar. Should I resubmit this patch as well?

Yes, please. Add the collected Acked-bys and submit everything that is
missing in v3.10-rc6.


	Joerg
