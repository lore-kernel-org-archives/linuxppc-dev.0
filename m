Message-ID: <39C1E470.ACE122F@student.ethz.ch>
Date: Fri, 15 Sep 2000 10:57:20 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
References: <200009140546.HAA00808@piglet.grunz.lu> <39C155BF.1A150162@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

> In fact, I don't see any difference between the situation before and after
> the patch. For x11perf --scroll500, I get exactly as before 36.2/sec for
> 1024x768 at 8bit. This is with XFree68-4.0.1; used to be 13/sec with older X
> servers.

X 4.x has ShadowFB, which shadows the framebufer in RAM and avoids reads from
VRAM.

I think Michel (the other one ;) either uses X 3.3.x or no ShadowFB.


Michel


PS: My Rage128 Mobility gives me 578.0/sec :)

--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
