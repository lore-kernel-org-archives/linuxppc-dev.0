Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 7BD282C0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 20:12:38 +1000 (EST)
Date: Mon, 15 Jul 2013 15:03:43 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Dan Williams <djbw@fb.com>
Subject: Re: [PATCH 00/12] dma: various minor clean ups for slave drivers
Message-ID: <20130715093343.GN16653@intel.com>
References: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130530174727.GE3767@intel.com>
 <CAA9_cmdNiLfJjv-8Mh-Xb1ifZb4aw_9NGCVW6aWsfq6BN-DYyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA9_cmdNiLfJjv-8Mh-Xb1ifZb4aw_9NGCVW6aWsfq6BN-DYyQ@mail.gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
 Zhang Wei <zw@melbourneit.hotkeysparking.com>, linux-tegra@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 31, 2013 at 05:09:51PM -0700, Dan Williams wrote:
> On Thu, May 30, 2013 at 10:47 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Mon, May 27, 2013 at 03:14:30PM +0300, Andy Shevchenko wrote:
> >> Here is a set of small independent patches that clean up or fix minor things
> >> across DMA slave drivers.
> > The series looks fine. I am going to wait a day more and apply, pls speak up if
> > you disagree and ack if you agree
> 
> Looks ok to me.  Reminds we can probably take this one step further
> and provide a generic implementation for the common case.  It's just a
> bit inconsistent though that some engines will poll the completion
> handler (try to advance the state of the last completed cookie)
> whereas others just assume things will be completed asynchronously.
agree with that. These are the inconsistencies some of which are based on
hardware and some are user iterpretations...

--
~Vinod
