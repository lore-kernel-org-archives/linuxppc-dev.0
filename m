Date: Sun, 26 Aug 2001 21:54:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup
Message-ID: <20010826215436.H1481@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010826212415.G1481@cpe-24-221-152-185.az.sprintbbd.net> <22664.998886680@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22664.998886680@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 27, 2001 at 02:31:20PM +1000, Keith Owens wrote:
> On Sun, 26 Aug 2001 21:24:15 -0700,
> Tom Rini <trini@kernel.crashing.org> wrote:
> >right combo of defines to turn on and have it compile), so I hacked
> >drivers/char/drm/drm_context.h (this is based on Linus' tree, which is all
> >I've got right now, sorry) to blindly call get_cycles.  Assuming that
> >r128_context_switch is the context_switch in drivers/char/drm/drm_context.h,
> >I had an __archdata section, but it was empty.
>
> Did the .o file have section __ftr_fixup?  Use objdump -h.  And did
> insmod pick up that newly compile module or did it pick up the
> installed version?

I guess I should go get some sleep now... __archdata is 8 not 0, but the
last section I see (insmod -nm ./r128.o > r128.out) is the .bss...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
