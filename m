Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id C0B1467A72
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 04:03:27 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Bora ?ahin <bora.sahin@ttnet.net.tr>
In-Reply-To: <20050201093352.A30421@cox.net>
References: <528646bc0501191635b1d318a@mail.gmail.com>
	<41EF3626.4060502@kegel.com>
	<528646bc05012715092fd0c5ad@mail.gmail.com>
	<1849856903.20050130181456@ttnet.net.tr>
	<528646bc05013107535a422f16@mail.gmail.com>
	<opslg6nunu49uzoa@localhost>
	<16211604486.20050201144642@ttnet.net.tr> <opslirxnwd49uzoa@localhost>
	<3116599689.20050201160957@ttnet.net.tr>
	<20050201093352.A30421@cox.net>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 18:03:24 +0100
Message-Id: <1107277404.11174.16.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [linux-cirrus] Re: Cirrus Logic MaverickCrunch support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-02-01 at 09:33 -0700, Matt Porter wrote:
> On Tue, Feb 01, 2005 at 04:09:57PM +0200, Bora ?ahin wrote:
> > Hi,
> > 
> > Torben> I'm fairly sure that decoding of
> > Torben> mpeg2 video in most cases would be too slow to consider without the help  
> > Torben> of some kind of graphical decoder chip.
> > 
> > Unless you use some powered CPU. As it would require to give an example, MPC8540(667-800 MHz) from
> > PPC family seems ideal for it as a SoC solution...
> 
> Even then, this depends completely on what else the platform has to
> do as well as what profile/level of MPEG-2 you are decoding. Something
> like a ~800Mhz e500 core has no chance of handling a main profile high
> level MPEG-2 stream for playback (typically 720p/1080i video). A high-end
> (1.45Ghzish) 7457 with an optimized altivec mpeg2 software decode library
> and a video card with iDCT assist is about the minimum PPC for these
> applications.

Maybe you want to hook up some hardware MPEG decoder to the
Siliconmotion SM501's Zoom Video port.

I'm currently hacking on the XOrg driver for that graphics chip
and could well use a partner in crime ;-)

In any case, if you use a e500 core you want to make sure you get away
with single-precision floating point arithmetics.

-- 
Stefan Nickl
Kontron Modular Computers
