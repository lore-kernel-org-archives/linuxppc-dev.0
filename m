Subject: Re: Serial Console on XServe and yaboot???
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030311223353.00f9a059.billfink@mindspring.com>
References: <20030311223353.00f9a059.billfink@mindspring.com>
Content-Type: text/plain
Message-Id: <1047455184.18956.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 12 Mar 2003 08:46:25 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-03-12 at 04:33, Bill Fink wrote:
> I'd like to use the serial port on the XServe as a serial console.
> I enabled CONFIG_SERIAL_CONSOLE in a 2.4.20-0.7b (YDL 2.3) kernel,
> set the OF input-device and output-device parameters to ttya, and
> booted with the kernel argument "console=ttyS0,38400".
>
> This actually works once the system starts booting.  My problem
> is that I never get a chance to interact with yaboot and thus for
> example can't select a different Linux kernel to boot.  Is there
> any way to accomplish this, for example by some suitable modification
> to the ofboot.b file in the boot partition?  Or is this just not
> supported by the hardware?
>
> Thanks in advance for any help or pointers, or even for informing
> me that this is a hopeless quest.

iirc, there is something weird with the OF params for the console
on the xserve. Try changing these:

intput-device    "scca"
output-device    "scca"
input-device-1   "scca"
output-device-1  "scca"

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
