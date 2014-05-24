Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8BF61A058F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 17:33:22 +1000 (EST)
Received: by mail-wi0-f174.google.com with SMTP id r20so1850131wiv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 00:33:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140522051023.GV21128@intel.com>
References: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
 <20140522051023.GV21128@intel.com>
Date: Sat, 24 May 2014 11:33:15 +0400
Message-ID: <CAF0T0X7v2oFkBOMETRCw128q=6wYZAX5qo3RQ7+0YwuVimMeMg@mail.gmail.com>
Subject: Re: [PATCH RFC v13 0/5] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, dmaengine@vger.kernel.org,
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

Thank you, Vinod

2014-05-22 9:10 GMT+04:00 Vinod Koul <vinod.koul@intel.com>:
> On Thu, May 15, 2014 at 06:15:30PM +0400, Alexander Popov wrote:
>> Changes in v13:
>>  A new patch (part 1/5) is added to this series.
>>  Part 2/5:
>>  - fix style issue;
>>  - improve comments;
>
> You need to cc DT- list for 3 to 5 patches. Need ack before we can apply.
In this v13 series parts 0/5, 3/5, 4/5 and 5/5 do have "Cc:
devicetree@vger.kernel.org".

> I suspect 4/5 should come first out of these 3.
Ok. I'll send v14 soon.

> Also in future pls use right subsystem name "dmaengine". Also why are these
> tagged as RFC still?
Ok, thanks.

Best regards,
Alexander
