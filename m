Subject: RE: 2.6 kernel ppc tree
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 19 Feb 2004 08:08:42 +1300
Message-ID: <A3240F62EF3C2749B1A25D3BC9548F41030A03@ExchWENZ02.wenz.global.vpn>
From: "Rod Boyce" <rod_boyce@stratexnet.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

You are correct I'm sure I have no time on this and I'm trying to get a image to build so I can see what is missing and then start debugging the image.  I have to start somewhere and this is where I started.  I also see there is a newer version so I will make another attempt in the next few day with that.

Rod Boyce

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Thursday, February 19, 2004 8:03 AM
To: Rod Boyce
Cc: Lokesh Kumar; linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 kernel ppc tree


That issue in particular has been fixed in later versions.  But
commenting out the ret_from_interrupt lines isn't quite enough to get
the platform booting :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
