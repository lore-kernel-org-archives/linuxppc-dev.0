Date: Wed, 12 Mar 2003 08:19:31 -0500
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: Serial Console on XServe and yaboot???
Message-Id: <20030312081931.2cafbb86.billfink@mindspring.com>
In-Reply-To: <1047455184.18956.27.camel@zion.wanadoo.fr>
References: <20030311223353.00f9a059.billfink@mindspring.com>
	<1047455184.18956.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On 12 Mar 2003, Benjamin Herrenschmidt wrote:

> On Wed, 2003-03-12 at 04:33, Bill Fink wrote:
> > I'd like to use the serial port on the XServe as a serial console.
> > I enabled CONFIG_SERIAL_CONSOLE in a 2.4.20-0.7b (YDL 2.3) kernel,
> > set the OF input-device and output-device parameters to ttya, and
> > booted with the kernel argument "console=ttyS0,38400".
> >
> > This actually works once the system starts booting.  My problem
> > is that I never get a chance to interact with yaboot and thus for
> > example can't select a different Linux kernel to boot.  Is there
> > any way to accomplish this, for example by some suitable modification
> > to the ofboot.b file in the boot partition?  Or is this just not
> > supported by the hardware?
> >
> > Thanks in advance for any help or pointers, or even for informing
> > me that this is a hopeless quest.
>
> iirc, there is something weird with the OF params for the console
> on the xserve. Try changing these:
>
> intput-device    "scca"
> output-device    "scca"
> input-device-1   "scca"
> output-device-1  "scca"

Thanks for the idea, but unfortunately it had no effect, as I saw
no yaboot screens show up when I did a reboot.  Is it possible that
the initial OF uses a different baud rate than 38400 (although I
didn't even see any garbage show up)?

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
