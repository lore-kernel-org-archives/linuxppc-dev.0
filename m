Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C203BB6EDF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 06:17:22 +1000 (EST)
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
From: fushen chen <fchen@apm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <201006301127.21241.sr@denx.de>
References: <12778468223309-git-send-email-fchen@apm.com>
	<201006301127.21241.sr@denx.de>
Content-Type: text/plain
Date: Wed, 30 Jun 2010 13:16:52 -0700
Message-Id: <1277929012.16379.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Wolfgang Denk <wd@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Mark Miesfeld <mmiesfeld@apm.com>,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stefan,

The driver is based on Synopsys driver 2.60a.

We started to prepare open source submission based on our internal
version. We sync this version to linux-2.6-denx repository from time to
time. I'll sync the driver to the latest linux-2.6-denx as Wolfgang
pointed out, and re-submit patch to open source.

We modified the driver mostly to follow Linux kernel coding style.  
Both USB host and device modes are tested. 

Thanks,
Fushen
     1. 

On Wed, 2010-06-30 at 11:27 +0200, Stefan Roese wrote:
> Hi Fushen, Hi Mark,
> 
> On Tuesday 29 June 2010 23:26:54 Fushen Chen wrote:
> > The DWC OTG driver module provides the initialization and cleanup
> > entry points for the DWC OTG USB driver.
> > 
> > Signed-off-by: Fushen Chen <fchen@apm.com>
> > Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> 
> I tried to compare this driver with the version that's currently available in 
> the linux-2.6-denx repository. But the differences are quite big. Could you 
> please list the history of this DWC driver? Things like:
> 
> - Which Synopsis version is it based upon?
> - What changes/enhancements/fixups where made from APM?
> - How was this driver tested (USB host and device mode)?
> 
> As Wolfgang already pointed out, the driver in our git repository has 
> undergone multiple changes/fixes. Did you take a look at them and try to 
> integrate them?
> 
> Thanks.
> 
> Cheers,
> Stefan
