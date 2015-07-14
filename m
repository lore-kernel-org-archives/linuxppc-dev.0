Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 7AC4C1A025F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 18:18:00 +1000 (AEST)
Date: Tue, 14 Jul 2015 18:17:40 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Andreas Schwab <schwab@linux-m68k.org>
cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <87d1zwc4dj.fsf@igel.home>
Message-ID: <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 13 Jul 2015, Andreas Schwab wrote:

> Finn Thain <fthain@telegraphics.com.au> writes:
> 
> > BTW, I didn't change the SCSI ID location in NVRAM. This code says 16 
> > whereas atari_scsi says 14. Which one is correct?
> 
> I think atari_scsi is wrong.  The best source I could find 
> (http://www.gratifiant.com/nvram-falcon-t561185) places it after the 
> video mode byte, thus at byte 16.

Thanks for that. BTW, I googled a phrase from that page and found this one
  http://toshyp.atari.org/en/004009.html
which may be closer to the source.

I'll send a patch if someone can offer to test such a change to atari_scsi 
(or merely confirm that the SCSI ID setting in TOS does not match this_id 
given in dmesg).

-- 
