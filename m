Date: Fri, 12 Oct 2001 09:17:18 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: EliuG <guile@mac.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: VGA out on ibook2
In-Reply-To: <1002853526.3527.4.camel@milleniumfalcon>
Message-ID: <Pine.LNX.4.33.0110120914070.15541-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 	I'm trying to use the external VGA connector on an ibook2 (the white
> one) with the benh utility m3mirror and, after turning crt on, the
> screen on the monitor looks "wavy" and unusable.
> 	Anybody could guide me to solve this problem?

Dump the CRTC and CRTC2 registers (come to think of it, dump any of the
interesting registers). Compare with what you get after using MockOS to
set up the VGA display and booting with video=ofonly.

Use a scope to verify there is a hsync signal (I suspect it might not be
generated, or it's way out of spec.

> Also... anybody knows how to turn up the composite video output of the
> ibook2?

Apple knows. Examine their drivers.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
