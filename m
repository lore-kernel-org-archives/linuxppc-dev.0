Message-ID: <3703C19C.21CADED3@business.wm.edu>
Date: Thu, 01 Apr 1999 13:57:32 -0500
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Reply-To: kbhend@business.wm.edu
MIME-Version: 1.0
To: "Charles A. Jolley" <charles.jolley@zeratec.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bug in LinuxThreads?
References: <199904011626.KAA14371@www2.tuckeris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I ran your test program under R4.1 and with the very latest glibc 1.99 rpm from
Gary Thomas and it worked fine. (exited properly)

By the way, your comment in the code about how to compile is wrong (it is
libpthread.so NOT libpthreads.so) so -lpthread no -lpthreads

I have made a few changes to linuxthreads to improve performance with the JDK
1.2 native threads.  Please try with Gary's latest glibc 1.99 rpm (which has
libpthread in it).  It that doesn't work, I will post my libpthread.so and
libpthread.a for you to try.

If only my version works for you, I will post the diffs for you and you can roll
your own.

I hope this helps.

Kevin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
