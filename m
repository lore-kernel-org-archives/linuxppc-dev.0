Date: Mon, 5 Jan 2004 15:38:47 +0100
From: Wouter Cloetens <wouter@mind.be>
To: linuxppc-embedded@lists.linuxppc.org
Cc: v2p@mind.be
Subject: Re: [PATCH] Insight Memec Virtex-II Pro Development Board support
Message-ID: <20040105143847.GE31876@roadkill.intern.mind.be>
References: <20031212215601.GH3935@roadkill.intern.mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031212215601.GH3935@roadkill.intern.mind.be>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 12, 2003 at 10:56:01PM +0100, Wouter Cloetens wrote:
> If needed, we can also submit the diff against the linuxppc_2_4 tree.

That's available too now on ftp://ftp.mind.be/Virtex2Pro/patch-v2.4.23_linuxppc_2_4/.
One notable difference with the patch against the devel tree is that
I've applied a patch to allow the boot code to pick up the command line
from RedBoot (arch/ppc/boot/simple/misc-embedded.c).

> The patches should be applied in the following order:

See the README file in that directory.

> We commit to maintaining this port on an ongoing basis against the
> linuxppc_2_4 tree.

And that's still true. Would any of the committers be so kind as to
merge this into the linuxppc_2_4[_devel] trees? Or is there anything
else (besides posting the link to the patches here) we should do to get
this stuff in?
--
There are 10 types of people in the world: Those who understand binary, and those who don't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
