Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 889B3DE079
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 19:46:08 +1000 (EST)
Date: Wed, 6 Aug 2008 11:46:07 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: John Linn <John.Linn@xilinx.com>
Subject: RE: Kconfig debug help
In-Reply-To: <20080805225045.436FA68005D@mail2-dub.bigfish.com>
Message-ID: <Pine.LNX.4.64.0808061145400.28556@vixen.sonytel.be>
References: <20080805213759.96642158806D@mail101-wa4.bigfish.com>
	<1217976528.2328.54.camel@localhost.localdomain>
	<20080805225045.436FA68005D@mail2-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1311117823-1218015967=:28556"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1311117823-1218015967=:28556
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Aug 2008, John Linn wrote:
> Thanks Josh, I just came to the conclusion it was busted somehow in the
> mainline after repeating it there.

It was fixed in mainline by
commit 22127f246dc37ed5bea0915f7860002ba6d87da7
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Mon Aug 4 22:18:07 2008 +0200

    kconfig: always write out .config
    
    Always write out .config also in the case where config
    did not change.
    This fixes: http://bugzilla.kernel.org/show_bug.cgi?id=11230

> > -----Original Message-----
> > From: Josh Boyer [mailto:jwboyer@gmail.com] On Behalf Of Josh Boyer
> > Sent: Tuesday, August 05, 2008 4:49 PM
> > To: John Linn
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: Kconfig debug help
> > 
> > On Tue, 2008-08-05 at 15:37 -0600, John Linn wrote:
> > > I'm trying to debug some Kconfig problems and am looking for a way
> to
> > > get more debug output.
> > >
> > >
> > >
> > > I have used KBUILD_VERBOSE=1 on the command line and it didn't help
> > > much.
> > >
> > >
> > >
> > > I'm seeing an issue with creating a new defconfig file for a board.
> I
> > > get the .config created, then copy it to a defconfig, and then it
> > > doesn't do anything when I run make with the defconfig file.
> > 
> > Yeah, I hit that myself this weekend.  It's a bug in the Kconfig area.
> > It's 1/2 fixed in the latest Linus and powerpc trees.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-1311117823-1218015967=:28556--
