Message-ID: <3896D868.BE2A5C@ctam.com.au>
Date: Tue, 01 Feb 2000 23:58:16 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <200002010035.BAA26304@denx.local.net> <3896CEA3.EBA97957@ctam.com.au> <0001311713560A.00776@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

> Brendan,
>
> We use a serial connection to debug our applications with GDB all the time
> using stubs that are part of our "OS".  It certainly is possible.  We put the
> devices on the end of a 24 port Livingston Portmaster terminal server and then
> setup the ports as raw data ports to which we connect with GDB running on our
> main build/debug box.  That way the user can debug something in another room or
> across the planet very easily through the network.

Cool.  A little overkill never hurt anybody :)
I'll assume one build/debug box connected directly to the target via a serial cable
or ethernet for now.


> I debugged my initial port of the linux kernel to our platform using just this
> kind of interface.  You have to commandeer the serial hardware away from the
> driver - I simply didn't tell the kernel there was a device there and
> configured it "manually" from the GDB nub initialization function which I
> called early in main.c.  This works fine for KERNEL debugging.

When you say configured manually what exactly do you mean.
Is this in the kernel itself ?
When you say main.c do you mean init/main.c in the linux kernel source tree ?
Has this got anything to do with the kgdb option in the "make config" process ?
Can ethernet be used to debug the kernel or is a serial port the only or best way to
go ?


> For application debugging, you probably want to live in user space.  You COULD
> use gdbserver, I think, although I have no experience or knowledge of this.

I'm pretty sure gdbserver is the way to go for debugging applications.  A TCP
connection is a nice way to debug this.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
