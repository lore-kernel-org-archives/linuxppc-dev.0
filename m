Date: Tue, 6 Jun 2000 21:49:22 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Tony Mantler <nicoya@apia.dhs.org>
cc: mlan@cpu.lu, drow@false.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <v04003a00b5614aa89cff@[24.66.67.194]>
Message-ID: <Pine.LNX.4.10.10006062147140.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Anyways, that's the long answer. The short answer is: no, you probably
> don't want to cache the framebuffer.

Thanks for the long answer, and all those nasty gremlins have actually
been observed long time ago when people started to play with the
framebuffer drivers. At least on m68k, the framebuffer address space was
set non-cacheable right from the start (in head.S). I would hope that
somehow translated to PPC as well :-)

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
