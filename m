Date: Thu, 1 Jul 2004 13:34:21 +0200
To: Jens Schmalzing <j.s@lmu.de>,
	linux-fbdev-devel@lists.sourceforge.net,
	debian-kernel@lists.debian.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch, 2.6, ppc] some modular framebuffer support
Message-ID: <20040701113421.GA9187@pegasos>
References: <hh4qosi15h.fsf@alsvidh.mathematik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <hh4qosi15h.fsf@alsvidh.mathematik.uni-muenchen.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Let's bring linux-fbdev in the loop, as they probably are the best
placed to comment.

On Thu, Jul 01, 2004 at 10:26:18AM +0200, Jens Schmalzing wrote:
> Hi,
>
> the following patch allows some accelerated framebuffers (aty128fb,
> atyfb, radeonfb, and rivafb) and framebuffer console support itself to
> be built as modules on ppc.  Tested on a Powerbook Pismo, works very
> well including XFree86 and DRI.
>
> The first hunk suppresses a warning only, not sure about it.

Jens, i am not sure of the wisdom of pursuing this way. I know that
modularizing stuff and even fbdev drivers is a good thing, but i also
know that you plan to use this to modularize most fbdevs out of the
debian powerpc kernel.

I wonder at the implications, since modular fbdevs are loaded well later
than non-modular ones, and we thus lose lots of early log messages,
which may be ok for us hackers with a serial console ready to catch
them, but may be a nightmare for general users of the debian powerpc
package, not to speak about us who will have to do the support job on
those.

linux-fbdev folk, what is your take on this, would it be possible to
somehow get a way to have earlier debug messages, or to bring the
loading of fbdev modules to an earlier point ? Benh, where you working
on something such ? I think i remember something about this mentioned.

Or maybe i am wrong, and using a modular fbdev on a not offb supporting
powerpc is just fine.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
