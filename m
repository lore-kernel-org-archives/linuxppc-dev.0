Subject: Re: Physical Memory map holes in PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tameen Khan <tameen@cisco.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <00b001c428eb$2d8ae740$273147ab@amer.cisco.com>
References: <00b001c428eb$2d8ae740$273147ab@amer.cisco.com>
Content-Type: text/plain
Message-Id: <1082701889.6442.2.camel@gaston>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 16:31:30 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have looked through the boot memory allocator code for PPC and I dont find
> a similar memory map. They use a phys_avail array for boot memory allocation
> which is initialized to a single region from PPC_MEMSTART to total_memory.
> >From this it appears that there are no "holes" in physical memory map for
> PPC.

Most ppc32 don't, though it's fairly dependant on a given board. ppc64
do have holes, though at this point, it's not simple to get to them, the
data structure representing the physical memory map beeing marked __init...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
