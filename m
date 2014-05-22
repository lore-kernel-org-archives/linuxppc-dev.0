Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 336A91A05A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 15:26:18 +1000 (EST)
Date: Thu, 22 May 2014 10:40:23 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v13 0/5] MPC512x DMA slave s/g support, OF DMA lookup
Message-ID: <20140522051023.GV21128@intel.com>
References: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
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

On Thu, May 15, 2014 at 06:15:30PM +0400, Alexander Popov wrote:
> 2013/7/14 Gerhard Sittig <gsi@denx.de>:
> > this series
> > - introduces slave s/g support (that's support for DMA transfers which
> >    involve peripherals in contrast to mem-to-mem transfers)
> > - adds device tree based lookup support for DMA channels
> > - combines floating patches and related feedback which already covered
> >    several aspects of what the suggested LPB driver needs, to demonstrate
> >    how integration might be done
> 
> ...
> 
> Changes in v12:
>  A new patch (part 2/7) is added to this series.
>  Part 6/7:
>  - change the description of 'compatible' property according part 2/7;
>  - improve the document according Gerhard's feedback;
> 
> Parts 1/7, 2/7 and 4/7 have been applied by Vinod Koul and
> are excluded from v13.
> 
> Changes in v13:
>  A new patch (part 1/5) is added to this series.
>  Part 2/5:
>  - fix style issue;
>  - improve comments;

You need to cc DT- list for 3 to 5 patches. Need ack before we can apply.
I suspect 4/5 should come first out of these 3.

Also in future pls use right subsystem name "dmaengine". Also why are these
tagged as RFC still?

-- 
~Vinod
