Message-ID: <37C9DA7A.14DF14B0@dgs.monash.edu.au>
Date: Mon, 30 Aug 1999 11:12:26 +1000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: GLIBC wont compile for MPC860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am using egcs-1.1.2 powerpc-linux cross-compiler to compile
glibc-2.1.1.  The whole thing compiles fine (gee, doesn't it take a
while).

I tried compiling for the MPC860 with the following command "make
CFLAGS=-mcpu=860".  It got a little way but then died.  I think it is
trying to do something with floating point.

Is glibc known to compile for this processor ?
I'm pretty sure I need the -mcpu=860 option so that only mpc860 valid
instructions are generated.  Is this correct ?

I don't have the error message at hand but will post it if it will help.

What can I do to compile glibc for the MPC860 processor.

Thanks,
Brendan Simon.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
