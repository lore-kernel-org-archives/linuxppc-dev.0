Return-Path: <vinod.koul@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 2300C14007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:19:43 +1000 (EST)
Date: Fri, 2 May 2014 22:36:51 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v12 1/7] dma: mpc512x: reorder mpc8308 specific
 instructions
Message-ID: <20140502170651.GL32284@intel.com>
References: <1398261209-5578-1-git-send-email-a13xp0p0v88@gmail.com>
 <1398261209-5578-2-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398261209-5578-2-git-send-email-a13xp0p0v88@gmail.com>
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

On Wed, Apr 23, 2014 at 05:53:23PM +0400, Alexander Popov wrote:
> Concentrate the specific code for MPC8308 in the 'if' branch
> and handle MPC512x in the 'else' branch.
> This modification only reorders instructions but doesn't change behaviour.
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> Acked-by: Anatolij Gustschin <agust@denx.de>

Applied, thanks

-- 
~Vinod
