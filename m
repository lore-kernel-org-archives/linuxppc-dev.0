Message-Id: <v04003a01b4b27272e182@[216.81.20.207]>
In-Reply-To: <200001241852.KAA04045@sade.ddi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 24 Jan 2000 15:32:45 -0600
To: Jim Terman <terman@ddi.com>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: altivec instructions
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:52 PM -0600 1/24/00, Jim Terman wrote:
>We are trying to run a program that contains altivec instructions on a G4,
>but the process keeps crashing (gdb will actually cause a kernal panic).
>It looks like a bit in the MSR needs to be set.  What would be the best
>way to modify the kernel to let this happen?

Before you enable the MSR bit, you'll have to write altivec register saving
code for your kernel, the strategies for which were discussed a while back
on this mailing list, and should be available for your reading convinience
on the mailing list archive.

Following that, you'll have to check to be sure your code properly uses the
VRSAVE register, to avoid forward compatibility problems.


Once that's all done, your code should run just fine.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
