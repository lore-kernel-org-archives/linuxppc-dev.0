Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 142731A2351
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:20:23 +1000 (AEST)
Received: by obbop1 with SMTP id op1so106832429obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 01:20:21 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1508171756180.626@nippy.intranet>
References: <20150725074559.543547894@telegraphics.com.au>
 <CAMuHMdWUQsSG8cZmKX8tHMN1=87Og-xboAFzhP1vWyQF+A3_eg@mail.gmail.com>
 <alpine.LNX.2.00.1508171756180.626@nippy.intranet>
Date: Mon, 17 Aug 2015 10:20:21 +0200
Message-ID: <CAMuHMdWXgeA5ts+O2tJ+dqcXfeGkVuP7oxBuGTcZw3-dQqzfRA@mail.gmail.com>
Subject: Re: [RFC v5 00/26] Re-use nvram module
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Mon, Aug 17, 2015 at 10:04 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> BTW, checkpatch reported a few newly-introduced whitespace errors in
>> patches 03, 05, 16, 24, and 25.
>
> I will check again, but I'm sure those are all deliberate. I examined all
> the "errors" and "warnings" before submitting.
>
> checkpatch doesn't really understand the difference between whitespace
> used for indentation of statements (according to scope) and whitespace
> used for alignment of terms or parameters (when line-wrapped). Any tool
> that fails to make that distinction can't be depended upon to correctly
> validate the elisp in Documentation/CodingStyle, for example.

Checkpatch complains because you don't replace a sequence of 8 spaces
by a TAB in continuation lines.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
