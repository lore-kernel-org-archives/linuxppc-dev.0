From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Recent controlfb.c change in BK's linuxppc_2_3
Date: Thu, 13 Jul 2000 14:54:41 +0200
Message-Id: <20000713125441.25387@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000713071025.18408B-100000@ofey.inetnebr.com>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000713071025.18408B-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I've just noticed that the function, control_vram_reqd() was renamed to
>control_vram_read() in BK tree.  The function is supposed to calculate the
>amound of VRAM required for given vmode and cmode.  That's why it was
>named that *_reqd().  AFAICS, *_read() naming has no meaning and
>misleading.  Please change it back or rename it to something better.

Oops, sorry... q vs. a is a comon typo here in France, and I incorrectly
"fixed" this without looking the code too closely. I'll put a more
explicit name.

Thanks.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
