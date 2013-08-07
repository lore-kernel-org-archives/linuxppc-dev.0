Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A42D92C02A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 00:12:19 +1000 (EST)
Received: by mail-wi0-f177.google.com with SMTP id hq12so1734328wib.16
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Aug 2013 07:12:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130803155351.GK2580@book.gsilab.sittig.org>
References: <1375255292-11288-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130803155351.GK2580@book.gsilab.sittig.org>
Date: Wed, 7 Aug 2013 18:12:13 +0400
Message-ID: <CAF0T0X5YU=7Q=SmRvQ6Nr-awmext5EAk7SqtuqeLcySo1jazYw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/5] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <djbw@fb.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/8/3 Gerhard Sittig <gsi@denx.de>:
> On Wed, Jul 31, 2013 at 11:21 +0400, Alexander Popov wrote:
>>
> You don't provide a lot of information to those you want to
> receive feedback from.  You should keep a history and list the
> changes between versions.  And you may want to somehow link this
> v3 to its predecessor -- especially when you only send part of
> the series and assume that reviewers may know where to find the
> remainder.
>
> Please help those persons you want to get help from.

Thanks. Now I see how to collaborate via mailing lists properly.

> I think it's unfortunate to attribute the "will access
> peripheral" to the channel instead of the transfer job, and to
> set the flag from within the device control callback, and to
> nevery clear the flag (what will happen if a channel gets freed
> and reallocated by some other client?).
>
> I think that the peripheral access is an attribute of the
> transfer job, and should be setup in the prep routines (both set
> and cleared, depending on what gets setup).  This would be more
> robust and more readable (read: maintainable) in my eyes.

Yes. I agree, I will implement it and offer differences from RFC v2
in the initial topic.

Best regards,
Alexander.
