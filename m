Return-Path: <dan.j.williams@gmail.com>
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com
 [IPv6:2a00:1450:4010:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91E8C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 10:18:02 +1000 (EST)
Received: by mail-la0-f43.google.com with SMTP id fe20so424675lab.30
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 17:17:58 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <20130530174727.GE3767@intel.com>
References: <1369656882-25241-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130530174727.GE3767@intel.com>
Date: Fri, 31 May 2013 17:09:51 -0700
Message-ID: <CAA9_cmdNiLfJjv-8Mh-Xb1ifZb4aw_9NGCVW6aWsfq6BN-DYyQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] dma: various minor clean ups for slave drivers
From: Dan Williams <djbw@fb.com>
To: Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
 Zhang Wei <zw@zh-kernel.org>, linux-tegra@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 30, 2013 at 10:47 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, May 27, 2013 at 03:14:30PM +0300, Andy Shevchenko wrote:
>> Here is a set of small independent patches that clean up or fix minor things
>> across DMA slave drivers.
> The series looks fine. I am going to wait a day more and apply, pls speak up if
> you disagree and ack if you agree

Looks ok to me.  Reminds we can probably take this one step further
and provide a generic implementation for the common case.  It's just a
bit inconsistent though that some engines will poll the completion
handler (try to advance the state of the last completed cookie)
whereas others just assume things will be completed asynchronously.

--
Dan
