Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 015F4140119
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 23:42:21 +1000 (EST)
Message-ID: <1397482917.11914.128.camel@smile.fi.intel.com>
Subject: Re: [PATCH v3 6/8] DMA: Freescale: change descriptor release
 process for supporting async_tx
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hongbo Zhang <hongbo.zhang@freescale.com>
Date: Mon, 14 Apr 2014 16:41:57 +0300
In-Reply-To: <5347A8F2.4050603@freescale.com>
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
 <1397113805-24171-7-git-send-email-hongbo.zhang@freescale.com>
 <1397131003.11914.108.camel@smile.fi.intel.com>
 <5347A12F.8040006@freescale.com> <5347A8F2.4050603@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-11 at 16:33 +0800, Hongbo Zhang wrote:

> >>> +         * hardware channel, subsequent descriptors are either in
> >>> +         * process or have not been submitted
> >> Dot at the eol. Check in all comments.
> >
> > Even though I saw there are other comments without the dots, I think 
> > it is better to have it.
> > Thanks, all.
> >
> Hmm... think it again, it it really necessary to have it?
> Even I have it in my patch, there are already so many comments exists 
> without it.

For my opinion is better to keep style in your patches. Better if it
commonly used style in the driver. But comment against comments is
really minor thing.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
