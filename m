Subject: Re: linux x86 binaries on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Anderson <scott_anderson@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3E835BF0.756A152F@mvista.com>
References: <20030123151624.GA4998@iram.es> <20030123191224.GA1534@iliana>
	 <20030124094616.GA1832@iram.es> <1043413132.684.17.camel@zion.wanadoo.fr>
	 <20030124153858.GC5192@iram.es> <1043423977.684.33.camel@zion.wanadoo.fr>
	 <20030130083723.GA4654@iram.es> <1043916971.1028.6.camel@zion.wanadoo.fr>
	 <20030130094655.GA5883@iram.es> <1043922015.1023.12.camel@zion.wanadoo.fr>
	 <20030130110909.GA6697@iram.es> <1048772134.668.16.camel@zion.wanadoo.fr>
	 <3E835BF0.756A152F@mvista.com>
Content-Type: text/plain
Message-Id: <1048797615.1528.15.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 27 Mar 2003 21:40:15 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-03-27 at 21:15, Scott Anderson wrote:
> Benjamin Herrenschmidt wrote:
> >
> > Remember that old debate we had about 2 years ago about using an x86
> > emulator to run x86 binaries on linux/ppc ? Looks like Fabrice Bellard
> > did it ;)
> >
> > http://fabrice.bellard.free.fr/qemu/
>
> I wonder how it compares to bochs:
>   http://bochs.sourceforge.net/

After a quick look, it's much different.

bochs aims to completely emulate an x86 machine, including the
various HW devices, and in a portable way. I aims to run a whole
operating system (linux,windows,ms-dos, ...) within the emulator.
qemu is a dynamic recomiling emulator (thus less portable, though
potentially much faster) and doesn't do any HW emulation outside
of the CPU itself.
It translates syscalls to the kernel in order to run linux x86
userland binaries on linux ppc.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
