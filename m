Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFEBAB6EF2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 19:27:31 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
Date: Wed, 30 Jun 2010 11:27:20 +0200
References: <12778468223309-git-send-email-fchen@apm.com>
In-Reply-To: <12778468223309-git-send-email-fchen@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201006301127.21241.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, Wolfgang Denk <wd@denx.de>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fushen, Hi Mark,

On Tuesday 29 June 2010 23:26:54 Fushen Chen wrote:
> The DWC OTG driver module provides the initialization and cleanup
> entry points for the DWC OTG USB driver.
> 
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>

I tried to compare this driver with the version that's currently available in 
the linux-2.6-denx repository. But the differences are quite big. Could you 
please list the history of this DWC driver? Things like:

- Which Synopsis version is it based upon?
- What changes/enhancements/fixups where made from APM?
- How was this driver tested (USB host and device mode)?

As Wolfgang already pointed out, the driver in our git repository has 
undergone multiple changes/fixes. Did you take a look at them and try to 
integrate them?

Thanks.

Cheers,
Stefan
