Message-ID: <399AEF94.A927EE72@wanadoo.fr>
Date: Wed, 16 Aug 2000 21:46:28 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: Andreas Tobler <toa@pop.agri.ch>, Jack Howarth <howarth@bromo.med.uc.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4-test7 broken
References: <Pine.LNX.4.10.10008160749260.28397-100000@shell.unixbox.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ani Joshi wrote:
>
> FWIW, 2.4.0-test7-pre4 (kernel.org)  boots here on a 603e.  Few minor
> fixing up needed for the build, perhaps one of you should do a bk vs.
> kernel.org diff and find your problem.

Seems to have been the right idea. By putting the arch/ppc and
include/asm-ppc directories from linux-pmac-devel into my linux-bk-devel
copy and then applying the kernel.org test7-pre4 patch (plus some minor
fiddling), I have now a kernel that boots, calls itself 2.4.0-test7 and
still has the new input layer from the bk-devel tree.

It also should have the latest patches for RTC, but I cannot test this,
because I get
   hwclock: Open of /dev/rtc failed, errno=2: No such file or directory
just as with Paul's 2.4.0-test6 kernel. I am using devfs, so the
/dev/rtc device should be created automagically, and in 2.4.0-test5 this
worked.

What the problem was is hard to say, because there are now a lot of
diffs to the bk-devel tree.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
