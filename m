Date: Thu, 1 Jul 2004 10:47:07 -0400
From: David Eger <eger@havoc.gtf.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Jens Schmalzing <j.s@lmu.de>,
	linux-fbdev-devel@lists.sourceforge.net,
	debian-kernel@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-fbdev-devel] Re: [patch, 2.6, ppc] some modular framebuffer support
Message-ID: <20040701144707.GA22015@havoc.gtf.org>
References: <hh4qosi15h.fsf@alsvidh.mathematik.uni-muenchen.de> <20040701113421.GA9187@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040701113421.GA9187@pegasos>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


compiling radeonfb as a module works just fine for me in 2.6...
I don't see why you need a patch...

> linux-fbdev folk, what is your take on this, would it be possible to
> somehow get a way to have earlier debug messages, or to bring the
> loading of fbdev modules to an earlier point ?

If you want it for early boot text messages, don't bother with modules.
You can't unload fbcon, so you're not gonna be able to unload the fb
driver either.

-dte


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
