Return-Path: <schmitzmic@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B3A01A1BD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 13:52:17 +1000 (AEST)
Received: by pdbbh15 with SMTP id bh15so85688442pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:52:15 -0700 (PDT)
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
To: Finn Thain <fthain@telegraphics.com.au>,
 Andreas Schwab <schwab@linux-m68k.org>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <55AF1364.3080701@gmail.com>
Date: Wed, 22 Jul 2015 15:52:04 +1200
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
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

I'm afraid I cannot test anything on Atari hardware at present - my 
Falcon ate it's IDE disk partition table with all the fun that entails. 
Haven't even begun to try and recover that yet.

If you send a patch I could build a kernel and send that to Christian 
for testing (if he's got his Falcon up and running - might be a tad warm 
in the attic for that, in fact).

Cheers,

     Michael


Am 14.07.15 um 20:17 schrieb Finn Thain:
> On Mon, 13 Jul 2015, Andreas Schwab wrote:
>
>> Finn Thain <fthain@telegraphics.com.au> writes:
>>
>>> BTW, I didn't change the SCSI ID location in NVRAM. This code says 16
>>> whereas atari_scsi says 14. Which one is correct?
>> I think atari_scsi is wrong.  The best source I could find
>> (http://www.gratifiant.com/nvram-falcon-t561185) places it after the
>> video mode byte, thus at byte 16.
> Thanks for that. BTW, I googled a phrase from that page and found this one
>    http://toshyp.atari.org/en/004009.html
> which may be closer to the source.
>
> I'll send a patch if someone can offer to test such a change to atari_scsi
> (or merely confirm that the SCSI ID setting in TOS does not match this_id
> given in dmesg).
>
