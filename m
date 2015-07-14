Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E3D01A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 18:33:40 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linux\/m68k" <linux-m68k@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au>
 <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <CAMuHMdVGtdEMMMF87FAEuiKYyLZPQFQeaX5dH6DiATsmLxzJfw@mail.gmail.com>
Date: Tue, 14 Jul 2015 10:33:33 +0200
In-Reply-To: <CAMuHMdVGtdEMMMF87FAEuiKYyLZPQFQeaX5dH6DiATsmLxzJfw@mail.gmail.com>
 (Geert Uytterhoeven's message of "Tue, 14 Jul 2015 10:23:52 +0200")
Message-ID: <mvmegkbf89u.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, Jul 14, 2015 at 10:17 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> On Mon, 13 Jul 2015, Andreas Schwab wrote:
>>> Finn Thain <fthain@telegraphics.com.au> writes:
>>> > BTW, I didn't change the SCSI ID location in NVRAM. This code says 16
>>> > whereas atari_scsi says 14. Which one is correct?
>>>
>>> I think atari_scsi is wrong.  The best source I could find
>>> (http://www.gratifiant.com/nvram-falcon-t561185) places it after the
>>> video mode byte, thus at byte 16.
>>
>> Thanks for that. BTW, I googled a phrase from that page and found this one
>>   http://toshyp.atari.org/en/004009.html
>> which may be closer to the source.
>
> Hence "int" is 16-bits in all those references?

Yes, TOS uses 16-bit ints throughout.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
