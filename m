Return-Path: <vinod.koul@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by lists.ozlabs.org (Postfix) with ESMTP id 11E9B1A05A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 15:24:34 +1000 (EST)
Date: Thu, 22 May 2014 10:38:17 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v13 2/5] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20140522050817.GU21128@intel.com>
References: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
 <1400163335-29853-3-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400163335-29853-3-git-send-email-a13xp0p0v88@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Gerhard Sittig <gsi@denx.de>,
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

On Thu, May 15, 2014 at 06:15:32PM +0400, Alexander Popov wrote:
> Introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers.

Applied, after fixing sybstem name to "dmaengine"

-- 
~Vinod
