Message-Id: <9903292349.AA49680@marc.watson.ibm.com>
To: Dave Weis <djweis@plconline.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: modifying boot loader 
In-Reply-To: Message from Dave Weis <djweis@plconline.com>
   of "Mon, 29 Mar 1999 17:38:36 CST." <Pine.LNX.3.95.990329173630.305A-100000@catbert.desm.plconline.com>
Date: Mon, 29 Mar 1999 18:49:23 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Dave Weis writes:

Dave> linuxppc on a mca based rs6000. any pointers? :-) i have figured out that
Dave> when you hit start on the kernel, either r3 or r4 will point to an ipl_cb.
Dave> can you disclose if the boot loader looks for the symbol named start or
Dave> address 0x24?

	Are you sure the machine in question actually is a PowerPC system
as opposed to a POWER architecture RS/6000.  LinuxPPC will not run on
POWER architecture as LinuxPPC uses PowerPC instructions and memory
management is different.

	The pre-PREP / pre-CHRP RS/6000 loaders are extremely simplistic,
but I do not know the details.  If it understands XCOFF, then it might
look at the entry point for the "application" in the header to know the
starting address.

David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
