From: kbhend <kbhend@business.wm.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb broken under linuxppc r5 tools
Date: Sun, 1 Aug 1999 16:12:32 -0400
Content-Type: text/plain
References: <99080121250000.02221@ns1102.munich.netsurf.de>
MIME-Version: 1.0
Message-Id: <99080116170800.00474@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 01 Aug 1999, Franz Sirl wrote:
>
> Kevin, as a first measure, do you pass LD_BIND_NOW=1 in the environment?
> 
> Franz.

Yes, that is the default we set with the jdk.  Unfortunately it is no help.
Could this be kernel related?  I saw this problem with some of Paul's kernels
under R4 and then all problems with gdb went away.  Everything worked fine
under YDL but since my upgrade to LinuxPPC R5 and Paul's 2.2.10 kernel, the old
problems have re-appeared.

It is like some piece of cache is not being properly flushed.

By the way, I noticed from disassembling some code from egcs 1.1.2-12c that the
stwu instruction is being used again.  I thought Gary Thomas patched the egcs
source to prevent stwu from being generated becuase of some serious problems
with it being used in certain combinations on 604e systems.  Any info on this?

Thanks,

Kevin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
