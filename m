Date: Tue, 11 Mar 2003 22:33:53 -0500
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Serial Console on XServe and yaboot???
Message-Id: <20030311223353.00f9a059.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'd like to use the serial port on the XServe as a serial console.
I enabled CONFIG_SERIAL_CONSOLE in a 2.4.20-0.7b (YDL 2.3) kernel,
set the OF input-device and output-device parameters to ttya, and
booted with the kernel argument "console=ttyS0,38400".

This actually works once the system starts booting.  My problem
is that I never get a chance to interact with yaboot and thus for
example can't select a different Linux kernel to boot.  Is there
any way to accomplish this, for example by some suitable modification
to the ofboot.b file in the boot partition?  Or is this just not
supported by the hardware?

Thanks in advance for any help or pointers, or even for informing
me that this is a hopeless quest.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
