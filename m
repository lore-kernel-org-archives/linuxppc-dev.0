Date: Thu, 15 Apr 1999 11:47:51 +0100
From: Lars Hecking <lhecking@nmrc.ucc.ie>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Cc: costabel@wanadoo.fr, Tom Rini <tmrini@ntplx.net>,
        linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
Message-ID: <19990415114751.A26723@tehran.nmrc.ucc.ie>
References: <Pine.LNX.4.05.9904141910410.487-100000@pc.wackyland.com> <37158D29.132CCFC1@wanadoo.fr> <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>; from Franz Sirl on Thu, Apr 15, 1999 at 11:16:31AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> The problem could be egcs, there's a known varargs bug on PPC, which 
> happens as soon you have more than 8-10 args. There's a testcase for this 
> in the egcs testsuite, gcc.c-torture/execute/980608-1.c, which still fails 
> in the development sources. I hope this will be resolved for egcs-1.2 if 
> the rewrite of the function epilogue/prologue to use RTL makes it in time...

 Regardless whether this is an egcs problem or not, I'll check the patch
 into the gnuplot source tree. Watch out for gnuplot 3.7.0.6 beta :)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
