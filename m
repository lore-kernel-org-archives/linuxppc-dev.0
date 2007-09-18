Return-Path: <mike.koss@ngc.com>
Received: from xmrt0101.northgrum.com (xmrt0101.northgrum.com [208.20.220.55])
	by ozlabs.org (Postfix) with ESMTP id 486C8DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:38:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Xilinx FX60
Date: Tue, 18 Sep 2007 18:13:11 -0400
Message-ID: <E57AD4B83B37CA45A2BA1F0C5E4CD2EE02C92F0A@XMBVAD02.northgrum.com>
In-Reply-To: <1190150070.7268.34.camel@PisteOff>
References: <1190149090.7268.29.camel@PisteOff><fa686aa40709181402s633b6946k685a0bffe8bb7c10@mail.gmail.com>
	<1190150070.7268.34.camel@PisteOff>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Robert Woodworth" <rwoodworth@securics.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rob,

I have working image for that board that uses the MPMC2 that I've
successfully loaded our version of linux on. It uses a hacked-together
ll_temac driver. We did a lot of integration on that board before
finally moving to the ML410 because of not being able to get the SoDIMM
port to work.

-- Mike=20

-----Original Message-----
From: Robert Woodworth [mailto:rwoodworth@securics.com]=20
Sent: Tuesday, September 18, 2007 5:15 PM
To: Grant Likely
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx FX60

On Tue, 2007-09-18 at 15:02 -0600, Grant Likely wrote:
> >
> > The only difference is that the FX60 board only has 32MB DDR, I have

> > made sure that the correct memory size is in the kernel.
>=20
> How are you booting your kernel?  .ace? u-boot? load via debugger?

load via debugger (Xilinx xmd)

FYI: the board I'm using is the
TB-4V-FX60
http://www.hitechglobal.com/TED/V4PowerPC.htm

> Cheers,
> g.
>=20
