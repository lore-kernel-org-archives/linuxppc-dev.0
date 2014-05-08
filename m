Return-Path: <hongbo.zhang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CEFF14008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 20:04:10 +1000 (EST)
Message-ID: <536B568C.10402@freescale.com>
Date: Thu, 8 May 2014 18:03:56 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Vinod Koul <vinod.koul@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 6/8] DMA: Freescale: change descriptor release process
 for supporting async_tx
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-7-git-send-email-hongbo.zhang@freescale.com>
 <20140502165053.GH32284@intel.com>
In-Reply-To: <20140502165053.GH32284@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05/03/2014 12:50 AM, Vinod Koul wrote:
> On Fri, Apr 18, 2014 at 04:17:49PM +0800, hongbo.zhang@freescale.com wrote:
>
> This need review from Dan ...
>
Dan, could you please have a look at this? thanks.
