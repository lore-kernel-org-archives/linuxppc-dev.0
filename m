Message-ID: <37BA82B6.B4F39FFE@wanadoo.fr>
Date: Wed, 18 Aug 1999 11:53:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "Michael A. Thompson" <mat0001@jove.acs.unt.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stupid Question
References: <37BA5535.FC383590@jove.acs.unt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Michael A. Thompson" wrote:
> 
> 1. Which rpm contains the standard include headers?
> I come from mklinux and IRIX... I cant seem to find stdio.h stdlib.h
> etc... or sys/*.h directory. I installed the egcs c/c++ rpms,
> kernal-devel rpms and other gnu develope apps libs utils and headers but
> can find the standard stuff....

They are in the glibc-devel package.

> 2. is it normal for c++ includes to be here: /usr/include/g++-2?

Yes. Depends on your compiler. 

> 3. What is the normal file structure for linuxppc 5 include directory?
> is it like x86 linux, BSD, etc....

I don't know the others. One thing: Make sure that /usr/include/asm is a
link to /usr/src/linux/include/asm which in turn points to
/usr/src/linux/include/asm-ppc and /usr/include/linux points to
/usr/src/linux/include/linux (you do have the kernel headers installed,
don't you?)

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
