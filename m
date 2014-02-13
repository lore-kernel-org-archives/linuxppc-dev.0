Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 26C852C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 11:22:01 +1100 (EST)
Date: Thu, 13 Feb 2014 01:21:50 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v7 4/6] dma: mpc512x: add device tree binding document
Message-ID: <20140213002150.GJ4524@book.gsilab.sittig.org>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
 <1392211508-23615-5-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392211508-23615-5-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 12, 2014 at 17:25 +0400, Alexander Popov wrote:
> 
> From: Gerhard Sittig <gsi@denx.de>
> 
> introduce a device tree binding document for the MPC512x DMA controller
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> [ a13xp0p0v88@gmail.com: turn this into a separate patch ]

As stated in the previous iteration, this one no longer is good
enough.  As time has passed, we have moved forward and learned
something.  We would not write a binding like this today.
Admittedly I went dormant (did not provide an update) since v6.

There are several issues.
- The MPC512x DMA completely lacks a binding document, so one
  should get added.
- The MPC8308 hardware is similar and can re-use the MPC512x
  binding, which should be stated.
- The Linux implementation currently has no OF based channel
  lookup support, so '#dma-cells' is "a future feature".  I guess
  the binding can and should already discuss the feature,
  regardless of whether all implementations support it.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
