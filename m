Date: Tue, 1 Jul 2003 18:19:23 -0400
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question
Message-ID: <20030701181923.H20876@borg.org>
References: <20030701162944.E20876@borg.org> <20030701221239.GH954@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030701221239.GH954@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Tue, Jul 01, 2003 at 03:12:39PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 01, 2003 at 03:12:39PM -0700, Tom Rini wrote:
> After reading the follow ups, is the problem that the kernel never
> boots if you pass too large of a ramdisk or that the app does not
> work?

We have had cases where the kernel never boots once we turned on extra
debugging code, but in the case we are cornering now, the app causes
an oops, apparently on mallocing too much memory.

-kb, the Kent who is about to write up a simple test case of that.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
