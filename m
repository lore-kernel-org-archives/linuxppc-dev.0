Date: Mon, 29 Mar 1999 21:05:20 -0600 (CST)
From: Dave Weis <djweis@plconline.com>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: modifying boot loader 
In-Reply-To: <9903292349.AA49680@marc.watson.ibm.com>
Message-ID: <Pine.LNX.3.95.990329210222.1543A-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Mon, 29 Mar 1999, David Edelsohn wrote:
> >>>>> Dave Weis writes:
> Dave> linuxppc on a mca based rs6000. any pointers? :-) i have figured out that
> Dave> when you hit start on the kernel, either r3 or r4 will point to an ipl_cb.
> Dave> can you disclose if the boot loader looks for the symbol named start or
> Dave> address 0x24?
> 	Are you sure the machine in question actually is a PowerPC system
> as opposed to a POWER architecture RS/6000.  LinuxPPC will not run on
> POWER architecture as LinuxPPC uses PowerPC instructions and memory
> management is different.

It's a 7011-250, the first 601 machine. Actually I found a copy of AIXpert
online that had the announcement for the machine. 

> 	The pre-PREP / pre-CHRP RS/6000 loaders are extremely simplistic,
> but I do not know the details.  If it understands XCOFF, then it might
> look at the entry point for the "application" in the header to know the
> starting address.

I'll make it match on both counts then, 0x24 for start.
Is there some other disk based loader that does the BIST or is it totally
rom based? Also, is there any kind of command-line structure? Today I
figured out how to make a bootable floppy with my own kernel on it. I was
so happy to see the flashing 888's that showed it was mine :-)

dave

-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
http://www.plconline.com/ | "Great spirits will always encounter violent
                          | opposition from mediocre minds" - Einstein


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
