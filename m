From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Date: Sat, 14 Oct 2000 12:13:10 +0200
Message-Id: <19340908034454.27994@192.168.1.10>
In-Reply-To: <200010132147.XAA00867@piglet.grunz.lu>
References: <200010132147.XAA00867@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>No, the regions are larger. Apple's doc talks about '23 bits of IO
>space', which is 8M, at least for the first-generation bridges (bandit,
>that is).
>
>Anyway, the best way to find out the size of this region (unless you can
>read it from the bridge) is to look at the OF device tree, and the
>bridge's region properties.

Well, if IO decoding works like memory decoding on those bridges, then
yes, the region size is either 256 or 16Mb (large or sparse decoding).
The way it's currently setup by the BIOS, I beleive it's 16Mb. It's
possible that only 8MB out of the 16 are actually useable, we really lack
documentation about those chips.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
