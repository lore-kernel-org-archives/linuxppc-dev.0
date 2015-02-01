Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB6281A0D5B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 20:12:03 +1100 (AEDT)
Received: by mail-ob0-f175.google.com with SMTP id va2so880559obc.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Feb 2015 01:11:59 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
Date: Sun, 1 Feb 2015 10:11:59 +0100
Message-ID: <CAMuHMdXcV8nxCvhMDZ3WRrWKXxxjR6d8Uf8gp5w9NUTkyTNTjg@mail.gmail.com>
Subject: Re: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 1, 2015 at 4:39 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 4 Jan 2015, Geert Uytterhoeven wrote:
>
>> On Sun, Jan 4, 2015 at 8:21 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> > On Thu, 1 Jan 2015, Rickard Strandqvist wrote:
>> > > Removes some functions that are not used anywhere:
>> > > mac_pram_write() mac_pram_read()
>> >
>> > ... I'd rather not remove all of this code. Better to finish the
>> > implementation.
>>
>> Indeed.
>>
>> > Would it be acceptable to utilize drivers/char/generic_nvram.c and
>> > CONFIG_GENERIC_NVRAM? This is the PowerMac PRAM driver but looks
>> > generic enough that it may not need any modification for 68k Macs.
>>
>> Yes, that would be great.
>>
>
> Unfortunately, it seems to be unworkable.

An alternative could be to just provide an nvram attribute file in sysfs,
like many RTC drivers do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
