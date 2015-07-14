Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 848B91A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 18:23:54 +1000 (AEST)
Received: by oiab3 with SMTP id b3so120353oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 01:23:52 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au>
 <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
Date: Tue, 14 Jul 2015 10:23:52 +0200
Message-ID: <CAMuHMdVGtdEMMMF87FAEuiKYyLZPQFQeaX5dH6DiATsmLxzJfw@mail.gmail.com>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 14, 2015 at 10:17 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 13 Jul 2015, Andreas Schwab wrote:
>> Finn Thain <fthain@telegraphics.com.au> writes:
>> > BTW, I didn't change the SCSI ID location in NVRAM. This code says 16
>> > whereas atari_scsi says 14. Which one is correct?
>>
>> I think atari_scsi is wrong.  The best source I could find
>> (http://www.gratifiant.com/nvram-falcon-t561185) places it after the
>> video mode byte, thus at byte 16.
>
> Thanks for that. BTW, I googled a phrase from that page and found this one
>   http://toshyp.atari.org/en/004009.html
> which may be closer to the source.

Hence "int" is 16-bits in all those references?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
