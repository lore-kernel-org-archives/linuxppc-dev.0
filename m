Return-Path: <scottwood@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 329402C0301
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:47:31 +1100 (EST)
Message-ID: <1386707357.10013.114.camel@snotra.buserror.net>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
From: Scott Wood <scottwood@freescale.com>
To: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
Date: Tue, 10 Dec 2013 14:29:17 -0600
In-Reply-To: <34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1384973243.2879.361.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
 <1385066603.2879.414.camel@ul30vt.home>
 <1385066835.1403.489.camel@snotra.buserror.net>
 <1385067648.2879.421.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
 <1386288052.7375.100.camel@snotra.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07251EFF@039-SN2MPN1-012.039d.mgd.msft.net>
 <1386357907.7375.127.camel@snotra.buserror.net>
 <34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Stuart Yoder <stuart.yoder@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, "agraf@suse.de" <agraf@suse.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 'Wood Scott-B07421' <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My e-mail address is <scottwood@freescale.com>, not
<IMCEAEX-_O=MMS_OU=EXTERNAL+20+28FYDIBOHF25SPDLT
+29_CN=RECIPIENTS_CN=F0FAAC8D7E74473A9EE1C45B068D838A@namprd03.prod.outlook.com>

On Tue, 2013-12-10 at 05:37 +0000, Bharat.Bhushan@freescale.com wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, December 07, 2013 12:55 AM
> > To: Bhushan Bharat-R65777
> > Cc: Alex Williamson; linux-pci@vger.kernel.org; agraf@suse.de; Yoder Stuart-
> > B08248; iommu@lists.linux-foundation.org; bhelgaas@google.com; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> > 
> > If the administrator does not opt into this partial loss of isolation, then once
> > you run out of MSI groups, new users should not be able to set up MSIs.
> 
> So mean vfio should use Legacy when out of MSI banks?

Yes, if the administrator hasn't granted permission to share.

-Scott
