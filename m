Date: Thu, 15 Apr 1999 14:28:30 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
cc: costabel@wanadoo.fr, Tom Rini <tmrini@ntplx.net>,
        linuxppc-dev@lists.linuxppc.org, bug-gnuplot@dartmouth.edu
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <4.2.0.32.19990415110711.0410aa80@mail.lauterbach.com>
Message-ID: <Pine.HPP.3.96.990415142127.1720A-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 15 Apr 1999, Franz Sirl wrote:

> The problem could be egcs, there's a known varargs bug on PPC, which 
> happens as soon you have more than 8-10 args. There's a testcase for this 
> in the egcs testsuite, gcc.c-torture/execute/980608-1.c, which still fails 
> in the development sources. I hope this will be resolved for egcs-1.2 if 
> the rewrite of the function epilogue/prologue to use RTL makes it in time...

Is it related to alignment ? I've already been bitten by the fact that
some alignment constraint has changed between versions of egcs: now
doubles and long long are aligned on a 4 byte boundary when they are
passed in the memory area, earlier versions enforced 8 byte alignment in
these cases AFAIR.

That's the kind of changes I positively hate :-( 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
