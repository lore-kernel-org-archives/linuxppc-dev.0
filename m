Date: Thu, 6 May 1999 11:52:51 +1000
Message-Id: <199905060152.LAA00535@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: somer@nortelnetworks.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <03E3E0690542D211A1490000F80836F4877E30@zcard00f.ca.nortel.com>
	(somer@nortelnetworks.com)
Subject: Re: Strange mapping at 0xffc00000
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <03E3E0690542D211A1490000F80836F4877E30@zcard00f.ca.nortel.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have started using the 2.2.5 kernel from 2.1.24 previously, and have found
> a
> new 4 Meg mapping up at 0xffc00000 that was not there before.  This mapping
> is
> setup in arch/ppc/kernel/pmac_setup.c, in routine pmac_setup_arch with the
> following line:
> 
>         __ioremap(0xffc00000, 0x400000, pgprot_val(PAGE_READONLY));

This is the Mac ROM.  I put that in when I was doing some experiments
to do with emulating the Mac hardware and running macos in user mode.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
