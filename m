Date: Thu, 5 Aug 1999 11:41:10 +1000
Message-Id: <199908050141.LAA10285@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199908041025.MAA00244@piglet.cpu.lu> (message from Michel
	Lanners on Wed, 4 Aug 1999 12:25:09 +0200 (CEST))
Subject: Re: OF booting of G3-upgraded 7600?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199908041025.MAA00244@piglet.cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners <mlan@cpu.lu> wrote:

> Default Catch!, code=FFF00400

That's an instruction access exception.  What were the srr0 and srr1
values?  Also, doing ".registers" will show the state of all of the
registers.

> - on subsequent 'boot' commands:
> 
> 0> boot Claim failed

The loader is trying to use memory that is already allocated, since it
was allocated by the loader last time. :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
