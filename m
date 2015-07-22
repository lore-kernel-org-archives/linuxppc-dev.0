Return-Path: <cts@steigies.net>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
 [151.189.21.41])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 001721A1BFF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 00:33:44 +1000 (AEST)
Date: Wed, 22 Jul 2015 16:32:27 +0200
From: "Christian T. Steigies" <cts@debian.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
Message-ID: <20150722143227.GB4738@guido.earth.sol>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au>
 <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 22, 2015 at 02:22:21PM +1000, Finn Thain wrote:
> 
> On Wed, 22 Jul 2015, Michael Schmitz wrote:
> 
> > Hi Finn,
> > 
> > I'm afraid I cannot test anything on Atari hardware at present - my 
> > Falcon ate it's IDE disk partition table with all the fun that entails. 
> 
> That doesn't sound good.
> 
> > Haven't even begun to try and recover that yet.
> > 
> > If you send a patch I could build a kernel and send that to Christian 
> > for testing (if he's got his Falcon up and running - might be a tad warm 
> > in the attic for that, in fact).
> 
> Anyone with a suitable Atari, i.e. ATARIHW_PRESENT(TT_CLK), who can boot 
> both TOS and Linux could resolve the question. (Perhaps with an emulator?)

The Falcon is not powered on currently but it should still work. What should
I test?

> Any old kernel binary would do, since atari_scsi should print either 
> "HOSTID=n" or "this_id n" at startup.
> 
> If n doesn't agree with what TOS says about the host's SCSI ID, then I 
> think a trivial patch is safe enough. Especially if cat /proc/driver/nvram 
> produces a "SCSI host ID : m" that does agree with TOS.

Christian
