Message-ID: <389704A9.444FA736@netx4.com>
Date: Tue, 01 Feb 2000 11:07:05 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <200002010035.BAA26304@denx.local.net> <3896CEA3.EBA97957@ctam.com.au> <38968BC0.6FD6E801@netx4.com> <38976797.F621D0A9@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan John Simon wrote:


> The memory controller is setup in my boot loader.  It knows nothing about VMA, only
> PMA.

This has nothing to do with the 8xx memory controller.  It is the
way the Linux kernel maps its virtual space.


> I am happy with this but am not sure what the DRAM address should be.
> Should I map CS1 and CS2 to 0x00000000 or 0xC0000000 ?

DRAM should map to 0.

> ...  I sounds
> like I will probably need it to access my peripherals from within linux.  Is this
> correct ?

Yes.  It is simply the kernel memory mapping function, similar
to what mmap() does in a user application.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
