Date: Mon, 7 Jun 2004 13:08:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newest "bk pull" of 8xx tree still builds a kernel that hangs
Message-ID: <20040607200811.GD12823@smtp.west.cox.net>
References: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 07, 2004 at 11:55:33AM -0400, Robert P. J. Day wrote:

>
>   having just got back from vacation, i may have missed some of the latest
> developments.  i just did a "bk pull" from the linuxppc-2.5 tree, rebuilt
> the kernel for my 8xx board and, just like before i left, the kernel hung
> almost immediately upon booting:
>
> Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
> Uncompressing Linux...done.
> Now booting the kernel
> (hang)
>
> should i be expecting this?  once upon a time, of course, i got all the
> way to user space before the hang.  have there been some recent patches to
> cause this latest behaviour?  i haven't messed with the config file in
> quite some time.  should i?

What probably happened is that you don't have a UART driver selected.
I've had my best luck with CONFIG_SERIAL_CPM, so you might want to try
that.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
