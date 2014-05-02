Return-Path: <vinod.koul@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 47ACE140164
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:19:49 +1000 (EST)
Date: Fri, 2 May 2014 22:37:13 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v12 2/7] dma: mpc512x: separate 'compatible' values
 for MPC512x and MPC8308
Message-ID: <20140502170713.GM32284@intel.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
 <1398261209-5578-3-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398261209-5578-3-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2014 at 05:53:24PM +0400, Alexander Popov wrote:
> MPC512x and MPC8308 have similar DMA controllers, but are independent SoCs.
> DMA controller driver should have separate 'compatible' values for these SoCs.
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
Applied, thanks

-- 
~Vinod
