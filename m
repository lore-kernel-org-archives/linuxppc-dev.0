Date: Mon, 9 Jul 2001 13:37:47 -0700 (MST)
From: Jeff Rugen <jprugen@earthlink.net>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
In-Reply-To: <20010709204808.A12487@suse.de>
Message-ID: <Pine.LNX.4.21.0107091331300.1795-100000@raptor.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Jul 2001, Olaf Hering wrote:

> On Mon, Jul 09, Jeff Rugen wrote:
>
> > I did have VGA console be the default, and installed clgenfb as a module.
>
> Is there a way to rmmod the module later?
> The colors are wrong in X whit >8bit and the console is slow with fbcon :)
>

I haven't tried removing it, but as far as I know, support for that still
isn't there.  I tended to use Xbh rather than XFBDev for my X server,
because Xbh it at least had some acceleration in it.  But I am still using
3.3.6 (or something like that) for X.  I don't know if Xbh is downloadable
from anywhere these days, but I had planned on playing with X once 2.4.x
is relatively stable on my machine.  What version of X do people run on
the PowerStack these days (if at all)?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
