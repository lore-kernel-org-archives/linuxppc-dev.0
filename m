Date: Thu, 6 May 1999 15:16:39 +1000
Message-Id: <199905060516.PAA00644@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ranga@CSUA.Berkeley.EDU
CC: flar@cegt201.bradley.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: <199905060132.SAA26948@soda.CSUA.Berkeley.EDU> (message from
	Sriranga Veeraraghavan on Wed, 05 May 1999 18:32:09 -0700)
Subject: Re: USB under LinuxPPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199905060132.SAA26948@soda.CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU> wrote:

> As for SMP kernels, I have only been able to get 2.2.0pre6 with the
> file vmscan.c backward patched to 2.2.0pre4 to boot into SMP mode
> correctly. The 2.2.1 to 2.2.4 kernels don't boot at all in SMP mode,
> they crash in kswapd.  I haven't tried 2.2.5 yet, but from the traffic
> on this list I will probably hold off for a little while.

I fixed this problem around 2.2.5 or so.  It's fixed in the current
vger tree and in the samba.anu.edu.au::linux-pmac-devel rsync
repository.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
