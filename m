Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-we0-x22e.google.com (mail-we0-x22e.google.com
 [IPv6:2a00:1450:400c:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A55B2C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 00:11:01 +1000 (EST)
Received: by mail-we0-f174.google.com with SMTP id q54so1573150wes.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Aug 2013 07:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130803160628.GL2580@book.gsilab.sittig.org>
References: <1375255254-10955-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130803160628.GL2580@book.gsilab.sittig.org>
Date: Wed, 7 Aug 2013 18:10:56 +0400
Message-ID: <CAF0T0X6cwQPR4-imsev3Xd16usfjEABwm7hYxdJgvrMWZ=tBHA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/5] dma: mpc512x: reorder mpc8308 specific
 instructions
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
> On Wed, Jul 31, 2013 at 11:20 +0400, Alexander Popov wrote:
>>
> Please make sure to either cite
> properly or to properly mark changes as such.  Don't spread false
> information, please.  You are free to change what I submitted,
> but you should not pretend that I wrote what has become of the
> code after you have modified it.  Please fix the attribution.

Excuse me for the confusion.
I'll be careful with "From:" notes.

> Just to clarify:  The defines here appear to be more appropriate
> than the initial enums, after it turned out that we need not
> handle indiviudal channels in special ways, and really only need
> these three numbers (one of them being the maximum of the
> others).  But regardless of what you have changed, you should
> clearly state the fact.

Ok, I'll do so.

Best regards,
Alexander.
