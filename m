Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 6FE5C1A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 19:06:55 +1100 (AEDT)
Date: Fri, 17 Oct 2014 13:00:53 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Xuelin Shi <xuelin.shi@freescale.com>
Subject: Re: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
Message-ID: <20141017073053.GL1638@intel.com>
References: <1397202086-22489-1-git-send-email-xuelin.shi@freescale.com>
 <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
 <0c8d1963a25648f8a8f820bbc55afe4f@BL2PR03MB147.namprd03.prod.outlook.com>
 <CAPcyv4go1ghjD7fiEzwPJmcjRMBv7p0t7Sm9Ki=1Hu-0GKqoCQ@mail.gmail.com>
 <4cd56c90d1e44249bd2d417005183ec7@BL2PR03MB147.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4cd56c90d1e44249bd2d417005183ec7@BL2PR03MB147.namprd03.prod.outlook.com>
Cc: Harninder Rai <harninder.rai@freescale.com>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
 Naveen Burmi <NaveenBurmi@freescale.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2014 at 02:13:20AM +0000, Xuelin Shi wrote:
> Hi Dan & Vinod,
> 
> I have sent out the v4 of this patch and not received any further feedback yet.
> 
> This patch looks ruled out from the patchwork. https://patchwork.kernel.org/project/linux-dmaengine/list/?page=2
> 
> So do you know what happened to this patch?

First pls do not top post on mailing list

Yes I did clean patchworks this week for older patches, can you please
resubmit and we can review them

Thanks
-- 
~Vinod

> 
> Thanks,
> Xuelin Shi
> 
> 
> -----Original Message-----
> From: Shi Xuelin-B29237 
> Sent: 2014年4月15日 11:08
> To: 'Dan Williams'
> Cc: Koul, Vinod; andriy.shevchenko@intel.com; dmaengine@vger.kernel.org; linuxppc-dev; Rai Harninder-B01044; Burmi Naveen-B16502
> Subject: RE: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
> 
> Yes, "depend on !ASYNC_TX_CHANNEL_SWITCH" is better since fsldma selects this condition.
> 
> Thanks,
> Xuelin Shi
> 
> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams@intel.com]
> Sent: 2014年4月15日 8:30
> To: Shi Xuelin-B29237
> Cc: Koul, Vinod; andriy.shevchenko@intel.com; dmaengine@vger.kernel.org; linuxppc-dev; Rai Harninder-B01044; Burmi Naveen-B16502
> Subject: Re: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
> 
> On Sun, Apr 13, 2014 at 7:48 PM, Xuelin Shi <xuelin.shi@freescale.com> wrote:
> > Hi Dan,
> >
> > fsl dma device and fsl raid device are two differenct devices that 
> > both provide async_memcpy capability, so I use !FSL_DMA to disable the fsl dma device.
> >
> > That's to say, either select fsldma device, either fsl raid device.
> >
> 
> Right, but that's not what your proposed Kconfig dependency line does.
> 
> You want something like "depends on FSL_SOC && !(FSL_DMA || FSL_DMA=m)"
> 
> However, the more problematic option is ASYNC_TX_CHANNEL_SWITCH.  That option is problematic for RAID, so I propose "depend on !ASYNC_TX_CHANNEL_SWITCH" since that addresses both problems.
> 
> 

-- 
