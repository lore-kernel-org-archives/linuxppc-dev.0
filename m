Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 06D2367A6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 03:33:55 +1100 (EST)
Date: Tue, 1 Feb 2005 09:33:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Bora ?ahin <bora.sahin@ttnet.net.tr>
Message-ID: <20050201093352.A30421@cox.net>
References: <528646bc0501191635b1d318a@mail.gmail.com>
	<41EF3626.4060502@kegel.com>
	<528646bc05012715092fd0c5ad@mail.gmail.com>
	<1849856903.20050130181456@ttnet.net.tr>
	<528646bc05013107535a422f16@mail.gmail.com>
	<opslg6nunu49uzoa@localhost>
	<16211604486.20050201144642@ttnet.net.tr>
	<opslirxnwd49uzoa@localhost>
	<3116599689.20050201160957@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3116599689.20050201160957@ttnet.net.tr>;
	from bora.sahin@ttnet.net.tr on Tue, Feb 01, 2005 at 04:09:57PM
	+0200
Cc: Torben Vinther Schmidt <mariachi@itcampus.dk>, linuxppc-embedded@ozlabs.org
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

On Tue, Feb 01, 2005 at 04:09:57PM +0200, Bora ?ahin wrote:
> Hi,
> 
> Torben> I'm fairly sure that decoding of
> Torben> mpeg2 video in most cases would be too slow to consider without the help  
> Torben> of some kind of graphical decoder chip.
> 
> Unless you use some powered CPU. As it would require to give an example, MPC8540(667-800 MHz) from
> PPC family seems ideal for it as a SoC solution...

Even then, this depends completely on what else the platform has to
do as well as what profile/level of MPEG-2 you are decoding. Something
like a ~800Mhz e500 core has no chance of handling a main profile high
level MPEG-2 stream for playback (typically 720p/1080i video). A high-end
(1.45Ghzish) 7457 with an optimized altivec mpeg2 software decode library
and a video card with iDCT assist is about the minimum PPC for these
applications.

This is why most consumer products are using something with a decoder,
like the integrated one in the IBM STBxxxx chips or the Sigma Designs
decoders.

-Matt
