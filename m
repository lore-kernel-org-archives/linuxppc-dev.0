Date: Fri, 14 Mar 2003 11:27:46 -0500
From: Bill Fink <billfink@mindspring.com>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: Serial Console on XServe and yaboot???
Message-Id: <20030314112746.52828395.billfink@mindspring.com>
In-Reply-To: <20030314072405.GE20925@plato.local.lan>
References: <20030313222901.79512cfc.billfink@mindspring.com>
	<20030314072405.GE20925@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ethan,

On Thu, 13 Mar 2003, Ethan Benson wrote:

> On Thu, Mar 13, 2003 at 10:29:01PM -0500, Bill Fink wrote:
> >
> > Thanks a bunch for the info!  Using this method, with scca instead
> > of ttya, and a baud rate of 57600 (using a laptop), I was able to
> > verify this basically works.  The initial menu that asks you what
> > you want to boot (Linux, MacOS 9, MacOS X, etc) still goes to the
> > screen (at least it does if you have a screen attached) but the
>
> yes this is because i had to write all my text directly to the
> framebuffer, apple takes all kinds of special efforts to prevent
> `archaic peecee text' from showing up on the screen...  this problem
> should be fixed in yaboot 2.0
>
> i don't consider it too serious right now since if your doing serial
> console your probably not running any macos.
>
> you could probably fix this easily enough for your setup by altering
> the `.printf' definition in ofboot.

It's not a big deal since I only want to run Linux at the moment.

> > yaboot menu where you select the Linux kernel to boot does show
> > up on the serial port of the XServe, and this is what I'm most
> > interested in.  Now if I can just figure out how to set the baud
> > rate of the serial console for OF to 38400 or less to make my
> > console server happy, I'd be in business.  If nothing else I can
> > use the laptop approach which is at least a lot easier than toting
> > a big monitor around.
>
> hmm, not sure on that one.

I figured it out.  I just set the OpenFirmware parameters input-device
and output-device to scca:38400 and it worked fine (except it put my
window into reverse video mode for some reason).

						-Thanks again

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
