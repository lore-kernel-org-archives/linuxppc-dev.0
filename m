Date: Fri, 26 Mar 1999 12:31:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers 
In-Reply-To: <9903251912.AA56638@marc.watson.ibm.com>
Message-ID: <Pine.HPP.3.96.990326121245.1078X-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> 	My group at IBM Research also is looking for someone with operating
> system development experience to join our project:
> 
> 	http://www.research.ibm.com/kitchawan/
> 
> The project is targeted at multiprocessor systems utilizing 64-bit processors
> including PowerPC64.  An additional aspect is compatibility with glibc.

Do 64 bit PPC processors that can be bought as chips (not in a system) 
exist (i.e., can you buy a Power3 in a BGA package and the chipset that
goes with) ? 

Not many people have seen a 620 AFAICT :-( and the G4 I've seen announced
by Motorola is not what I expected: it's a super 750 with Altivec + 604
FPU (single cycle double precision multiplier) + SMP capabilities. 

But at least I expected:

- a 64 bit version (means >32 address pins, perhaps ~40 or so, 64 is
  obviously overkill right now and I don't ask for it)

- more superscalar (not 2+branch, but at least 4 way)

- longer in flight instruction queue

- 2 FPU: not sure, but divides seem to kill current PPC, one
  unit which can do all instructions(including sqrt) + one mult/add only
  would be great. OTOH, on FFT benchmarks which interest me also (not a
  single div), PPC are excellent. 

- 2 LSU to feed all these units: hey Pentium and PPro can do 2 memory
  accesses por clock since they came out. They need it because they
  require many load/store to compensate for the small number of registers 
  but I'd expect it to be beneficial even on PPC with large and fast 
  backside L2 caches. Power2 has had 2 LSU since the beginning AFAICT.   

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
