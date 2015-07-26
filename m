Return-Path: <schmitzmic@gmail.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 506D81A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 11:02:59 +1000 (AEST)
Received: by pdbnt7 with SMTP id nt7so31984834pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 18:02:57 -0700 (PDT)
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
To: Finn Thain <fthain@telegraphics.com.au>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol> <55B2DD88.2090804@gmail.com>
 <alpine.LNX.2.00.1507251722580.25996@nippy.intranet>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <55B43196.5@gmail.com>
Date: Sun, 26 Jul 2015 13:02:14 +1200
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1507251722580.25996@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Finn,

For the sake of completeness: further testing on ARAnyM shows no 
difference between original and patched kernel in the NVRAM proc and 
diff outputs:

scsi host0: Atari native SCSI, io_port 0x0, n_io_port 0, base 0x0, irq 
15, can_queue 8, cmd_per_lun 1, sg_tablesize 0, this_id 7, flags { }, 
options { REAL_DMA SUPPORT_TAGS }
Checksum status  : valid
Boot preference  : unspecified
SCSI arbitration : on
SCSI host ID     : 7
OS language      : English (US)
Keyboard language: English (US)
Date format      : DD.MM.YY, 24h clock
Boot delay       : 32s
Video mode       : 4 colors, 40 columns, TV NTSC monitor
                    no overscan, compat. mode off
00000000  00 00 00 00 00 00 00 00  11 2e 20 01 ff 00 00 3b |.......... 
....;|
00000010  87 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
00000030  de 21                                             |.!|
00000032
d640bf7d535b54e39582fabdc016d7ca  /dev/nvram
d640bf7d535b54e39582fabdc016d7ca  /tmp/nvram

Happy to help ...

Cheers,

     Michael

> On Sat, 25 Jul 2015, Michael Schmitz wrote:
>
>> Hi Christian,
>>
>> good to know this worked - for the record (Finn), this is the kernel
>> with Finn's patch applied.
> That was v5 of this patch series. I will send that out to the lists now.
> It has some minor changes that relate to powerpc.
>
> Thanks for your help with this, Michael.
>
> Finn
>
>> I'll build the missing LVM module so Christian can run the tests on the
>> unpatched kernel as well.
>>
>> Thanks for testing!
>>
>>      Michael
>>
>>
