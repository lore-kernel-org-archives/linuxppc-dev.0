Date: Mon, 29 Mar 1999 17:38:36 -0600 (CST)
From: Dave Weis <djweis@plconline.com>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: modifying boot loader 
In-Reply-To: <9903292336.AA42910@marc.watson.ibm.com>
Message-ID: <Pine.LNX.3.95.990329173630.305A-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> 	What are you actually trying to accomplish?  The values at

linuxppc on a mca based rs6000. any pointers? :-) i have figured out that
when you hit start on the kernel, either r3 or r4 will point to an ipl_cb.
can you disclose if the boot loader looks for the symbol named start or
address 0x24?

> pin_obj_start are not magic numbers or instructions but user-friendly
> values mapped at address 0.  It is trying to map values 0x0 and 0XBADFCA11

duh. that code didn't really seem to make much sense. thanks for the
enlightenment.

> (bad function call) so that dereferencing a data pointer or a PowerOpen
> ABI function pointer at address zero (0) will produce a visual clue.  This
> is produced by assembly like:
> 
> addr0:
>        .long   0
>        .long   0xBADFCA11
> 
> And you make the linker map label addr0 at physical address 0.

Cool. Project #1 tomorrow.

Thanks

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
