Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DD8E1A0E3B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 16:59:26 +1000 (AEST)
Received: by obbsn1 with SMTP id sn1so48281254obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 23:59:24 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1506181417260.30499@nippy.intranet>
References: <20150614074607.242676098@telegraphics.com.au>
 <20150614074613.054681242@telegraphics.com.au>
 <CAMuHMdWzKvWjAE3u54E4xewEDX+zJqEDEvRmO2twpeD2vmBzog@mail.gmail.com>
 <alpine.LNX.2.00.1506152213340.12762@nippy.intranet>
 <alpine.LNX.2.00.1506181417260.30499@nippy.intranet>
Date: Thu, 18 Jun 2015 08:59:24 +0200
Message-ID: <CAMuHMdX9BaBj4gFW4aP_t_GFsPQi_wU8-sQsUFr_A0cksr4MJQ@mail.gmail.com>
Subject: Re: [RFC v2 23/24] m68k/mac: Fix PRAM accessors
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

On Thu, Jun 18, 2015 at 6:49 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 16 Jun 2015, in which I wrote:
>> On Mon, 15 Jun 2015, Geert Uytterhoeven wrote:
>> > More magic values...
>>
>> [...] The only useful RTC documentation I've ever come across is this:
>> http://mac.linux-m68k.org/devel/plushw.php
>
> This document appears to be Inside Macintosh vol. III ch. 2. It describes
> the early RTC chip that lacks two-byte operations and XPRAM, and pre-dates
> all Mac hardware supported in mainline Linux. But it does offer some
> useful data, though not enough to answer all of your criticisms (as I
> said).

I understand.

>> [...] I think they should be applied across the entire file, and in a
>> different patch. Inconsistent use of such macros would be undesirable
>> IMHO.
>
> So, unless you have other ideas, I will revise this patch and insert an
> earlier patch to address existing code, and codify what little reliable
> chip data we have.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
