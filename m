Date: Mon, 29 Jan 2001 15:28:04 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010127163115.B2695@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.30.0101291524330.2636-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How do I set it up to log to a serial console?  (I may not be able to do
> this for a few days until I borrow a friend's laptop, though.)

console=/dev/ttyS0 in the kernel options.

> I did "dmesg -n 8" since I forgot the number and didn't have your email
> right in front of me, and it accepted that.  Does dmesg just tell the

Maybe 8 is OK as well.

> kernel what to send to syslogd, or does it tell it what to send to the
> current console directly?  If the former, how does this work on a

The debug level controls what sort of printk messages are sent to the
console device(s) directly. syslogd always gets a copy of everything
anyway.

> per-console basis?  If the latter, why would a serial console have a
> better chance of working?

Just in case the screen update is blocked by some interrupt disable stuff.
Serial console works without interrupts (at least it used to).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
