Date: Wed, 13 Jan 1999 16:14:25 -0500 (EST)
From: Tom Vier <nester@erols.com>
Reply-To: thomassr@erols.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <Pine.LNX.3.96.990112141237.3746A-100000@globegate.utm.edu>
Message-ID: <Pine.LNX.3.96.990113161217.4699D-100000@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, David A. Gatwood wrote:

> It's a lot harder than this, unfortunately.  The NuBus machines' memory
> isn't contiguous.  Thus, code would have to be written and/or obtained to

doh!

> find out what memory is available in the machine and where that memory is
> located in RAM.  That's going to be a nasty problem unless some code is
> pulled from the MkLinux booter.  I'd expect that to also require a
> substantial number of changes to the way memory is handled in linux, but I
> could be wrong.

hhmmm. don't some other arch's have non contiguous memory?

> Beyond that, it will also require changes to irq.c to handle the interrupt
> controller and a lot of code for DMA, if that's desired (I don't think
> it's even remotely similar, AFAICT).  Of course, that stuff can be
> obtained from Mach, but it'll be a lot of work.  Oh, and the i/o base
> address is different, which may or may not be a problem, and supporting
> certain pieces of hardware (which will remain nameless) will also require
> speed penalties (this is the other reason MkLinux is slower than
> LinuxPPC...).

what pieces of hardware? important ones?

--
Tom Vier - 0x82B007A8
thomassr@erols.com       | goto the Zero Page at:
Tortured Souls Software  | http://www.erols.com/thomassr/zero/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
