Message-ID: <3904829D.4C65D0AB@embeddededge.com>
Date: Mon, 24 Apr 2000 13:21:33 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
CC: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Debugging 8260 under gdb/linux?
References: <7283DE19D141D111AD0E00A0C95B195502581D14@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Gessner, Matt" wrote:


> Are there any such solutions for linux?

MontaVista has a boot rom with minimal debug support.  It is what
I used to do the initial port.  I will soon add the XMON and KGDB
support just like the 8xx has.

> What external hardware do I need?

I am not a fan of the JTAG/COP/BDM tools because once the kernel
starts up they just get in the way.  There is a small window of tough
debugging between jumping to the kernel and starting a serial port for
KGDB, and once past that I just use remote GDB.  Since the kernel already
boots way past that point, and none of this is board dependent, you
should only need a Linux development host.  Here, I prefer using the
native PowerPC Linux hosts (I like my iMac :-), and MontaVista has
cross tools for other platforms available.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
