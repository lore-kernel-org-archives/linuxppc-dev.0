Return-Path: <bora.sahin@ttnet.net.tr>
Received: from fep02.ttnet.net.tr (fep02fe.ttnet.net.tr [212.156.4.132])
	by ozlabs.org (Postfix) with ESMTP id C047067A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 05:18:46 +1100 (EST)
Date: Tue, 1 Feb 2005 20:19:45 +0200
From: =?ISO-8859-15?B?Qm9yYSDeYWhpbg==?= <bora.sahin@ttnet.net.tr>
Message-ID: <15831587099.20050201201945@ttnet.net.tr>
To: Matt Porter <mporter@kernel.crashing.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
Subject: Re[2]: [linux-cirrus] Re: Cirrus Logic MaverickCrunch support
Reply-To: =?ISO-8859-15?B?Qm9yYSDeYWhpbg==?= <bora.sahin@ttnet.net.tr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Matt> Even then, this depends completely on what else the platform has to
Matt> do as well as what profile/level of MPEG-2 you are decoding. Something
Matt> like a ~800Mhz e500 core has no chance of handling a main profile high
Matt> level MPEG-2 stream for playback (typically 720p/1080i video). A high-end
Matt> (1.45Ghzish) 7457 with an optimized altivec mpeg2 software decode library
Matt> and a video card with iDCT assist is about the minimum PPC for these
Matt> applications.

It is not that quality. I dont know decoding algoritms. But I have a film encoded bu Xvid.
Video Codec
     Aspect ratio: 592 x 320  (1.850 : 1)
     Frame/Sec   : 25
     Avg Bitrate : 1175 kb/s

I think quality is sufficiently enough. My Celeron 466/440 BX buddy does a good job.
     
Matt> This is why most consumer products are using something with a decoder,
Matt> like the integrated one in the IBM STBxxxx chips or

I am looking for probable and reasonable powerful cpu based solutions without going in that
direction...

Matt> the Sigma Designs decoders.

AFAIK, it does not support PPC platform...

-- 
Bora SAHIN
