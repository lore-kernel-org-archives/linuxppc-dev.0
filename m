Date: Fri, 18 Jun 1999 12:14:38 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Andreas Bogk <andreas@andreas.org>
cc: Brad Boyer <flar@cegt201.bradley.edu>,
        Joseph Palani Garcia <jpgarcia@execpc.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: EM86 port for LinuxPPC?
In-Reply-To: <m3emjivpao.fsf@soma.andreas.org>
Message-ID: <Pine.HPP.3.96.990618120418.11262E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 11 Jun 1999, Andreas Bogk wrote:

> And then there is bochs, which is a complete PC emulator, and which
> certainly could be modularized:
> 
> http://www.bochs.org
> 
> It reaches the speed of a 2 MHz 486 on my 300 MHz G3, so it's not
> exactly a viable option for running x86 binaries on PPC.

Indeed it's slow, but I looked once at the code of Bochs: performing
explictly the virtual to physical memory mapping by emulatingthe TLB in
software is not exactly cheap. That's an area where using hardware
resources with a hook in the kernel might speed up significantly. There
are other issues too (slow endianness conversion, ...)

Of course I did not have these problems with my emulator because it only
emulates a real mode 486SX for now, which runs at the speed of a 25 to 33
MHz 386DX on a 200Mhz PPC603e. 

I have some ideas to implement protected mode and to speed it up by maybe
30%, but abolutely no incentive to do it.  

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
