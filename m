From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup 
In-reply-to: Your message of "Sun, 26 Aug 2001 21:24:15 MST."
             <20010826212415.G1481@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 14:31:20 +1000
Message-ID: <22664.998886680@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Aug 2001 21:24:15 -0700,
Tom Rini <trini@kernel.crashing.org> wrote:
>right combo of defines to turn on and have it compile), so I hacked
>drivers/char/drm/drm_context.h (this is based on Linus' tree, which is all
>I've got right now, sorry) to blindly call get_cycles.  Assuming that
>r128_context_switch is the context_switch in drivers/char/drm/drm_context.h,
>I had an __archdata section, but it was empty.

Did the .o file have section __ftr_fixup?  Use objdump -h.  And did
insmod pick up that newly compile module or did it pick up the
installed version?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
