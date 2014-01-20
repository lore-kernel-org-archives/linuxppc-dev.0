Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id D4A3C2C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 19:45:28 +1100 (EST)
Date: Mon, 20 Jan 2014 13:13:49 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH] DMA: Freescale: change BWC from 256 bytes to 1024 bytes
Message-ID: <20140120074349.GH26823@intel.com>
References: <1389852653-8806-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389852653-8806-1-git-send-email-hongbo.zhang@freescale.com>
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 16, 2014 at 02:10:53PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> Freescale DMA has a feature of BandWidth Control (ab. BWC), which is currently
> 256 bytes and should be changed to 1024 bytes for best DMA throughput.
> Changing BWC from 256 to 1024 will improve DMA performance much, in cases
> whatever one channel is running or multi channels are running simultanously,
> large or small buffers are copied.  And this change doesn't impact memory
> access performance remarkably, lmbench tests show that for some cases the
> memory performance are decreased very slightly, while the others are even
> better.
> Tested on T4240.

Applied, thanks

--
~Vinod
