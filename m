Date: Tue, 1 Jul 2003 15:12:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large initrd and arch/ppc/boot/simple Question
Message-ID: <20030701221239.GH954@ip68-0-152-218.tc.ph.cox.net>
References: <20030701162944.E20876@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030701162944.E20876@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 01, 2003 at 04:29:44PM -0400, Kent Borg wrote:

> We are booting our kernel via the arch/ppc/boot/simple mechanism to
> package up our kernel and initrd.  It seems to work, until we get too
> big.  What is big?  Roughly 8 MB for our one big uncompressed userland
> program, plus the kernel, bash, busybox, and various userland
> utilities.
>
> Can initrd's get that large and still work?  Is the simple boot code
> sensible with these sizes?  (I notice that the "avail ram" message
> that gets printed is just hard coded number...)

After reading the follow ups, is the problem that the kernel never boots
if you pass too large of a ramdisk or that the app does not work?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
