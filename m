Message-ID: <393BA424.2E608C4@relog.ch>
Date: Mon, 05 Jun 2000 14:59:16 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: mlan@cpu.lu
CC: ajoshi@shell.unixbox.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
References: <200006041356.PAA00976@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> 1. What do the vc: and map: options do?

map: maps framebuffer devices to VCs. E.g. I use

	video=pm2fb:... video=amifb:... video=map:000011

So pm2fb is fb0 and amifb fb1, and VCs 1-4 are handled by pm2fb while 5 and
six are handled by amifb. Hope you get the idea.


> 2. Why can you specify more options after 'scrollback:', separated with
>    a ',', but not after the 'map:' option (no other options possible),

I guess it doesn't make sense to mix map: with device specific options because
it affects all devices.

>    whereas you can have more options following 'vc:', but without a
>    separator?

If only I knew what vc: is for :)


Michel


--
...and that is how we know the Earth to be banana-shaped.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
