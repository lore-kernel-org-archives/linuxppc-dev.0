Date: Sun, 24 Jun 2001 06:39:06 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: mlan@cpu.lu
Cc: guillaume.laures@noos.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re: getting the 8600 to boot 2.4.5
Message-Id: <20010624063906.594aea88.toe@unlserve.unl.edu>
In-Reply-To: <200106240954.LAA00837@piglet.grunz.lu>
References: <3B337C7B.1040309@noos.fr>
	<200106240954.LAA00837@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Jun 2001 11:54:29 +0200 (CEST), Michel Lanners wrote:

> Yeah; Takashi Oe fixed the VRAM detection for good, but it seems his
> patches have not made into any released tree yet.

Well, there is a problem with the detection code I wrote.
Occasionally, a machine hangs when vram mapping is changed.  It
seems it has to be done at a right time, but I don't know when
the right time is and how to detect it yet  :(

Any ideas or suggestions are welcome..


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
