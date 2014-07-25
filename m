Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 13CC91A0973
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 00:32:30 +1000 (EST)
Date: Fri, 25 Jul 2014 19:55:59 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH v3 0/3] dmaengine: mpc512x: add device tree binding
 document and DMA channel lookup
Message-ID: <20140725142559.GU8181@intel.com>
References: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403693580-9449-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Jun 25, 2014 at 02:52:57PM +0400, Alexander Popov wrote:
> This patch series introduces a device tree binding document for
> the MPC512x DMA controller and adds device tree based DMA channel lookup
> for it.
> 
> This version contains the improved device tree binding document:
> #dma-cells is made a required property, as it must be according
> dma/dma.txt document.

Applied, thanks

-- 
~Vinod
