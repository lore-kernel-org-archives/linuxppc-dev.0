Date: Thu, 13 Mar 2003 22:24:05 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Serial Console on XServe and yaboot???
Message-ID: <20030314072405.GE20925@plato.local.lan>
References: <20030313222901.79512cfc.billfink@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <20030313222901.79512cfc.billfink@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 13, 2003 at 10:29:01PM -0500, Bill Fink wrote:
>
> Thanks a bunch for the info!  Using this method, with scca instead
> of ttya, and a baud rate of 57600 (using a laptop), I was able to
> verify this basically works.  The initial menu that asks you what
> you want to boot (Linux, MacOS 9, MacOS X, etc) still goes to the
> screen (at least it does if you have a screen attached) but the

yes this is because i had to write all my text directly to the
framebuffer, apple takes all kinds of special efforts to prevent
`archaic peecee text' from showing up on the screen...  this problem
should be fixed in yaboot 2.0

i don't consider it too serious right now since if your doing serial
console your probably not running any macos.

you could probably fix this easily enough for your setup by altering
the `.printf' definition in ofboot.

> yaboot menu where you select the Linux kernel to boot does show
> up on the serial port of the XServe, and this is what I'm most
> interested in.  Now if I can just figure out how to set the baud
> rate of the serial console for OF to 38400 or less to make my
> console server happy, I'd be in business.  If nothing else I can
> use the laptop approach which is at least a lot easier than toting
> a big monitor around.

hmm, not sure on that one.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
