Message-Id: <200101190806.f0J86lH22497@denx.local.net>
To: xuelong wang <wang_xuelong@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: embedded questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Jan 2001 19:21:14 PST."
             <20010119032114.15637.qmail@web11805.mail.yahoo.com>
Date: Fri, 19 Jan 2001 09:06:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <20010119032114.15637.qmail@web11805.mail.yahoo.com>
Xuelong Wang wrote:
>
> 1. Do you have any experiences in compiling ppcboot
> packages(i.e. ppcboot-0.4.4-pre1 or ppcboot-0.6.2)? If

Yes, I do. As much experience as you get when writing and testing the
code.

> you have, please tell me what compiling environment
> (such as CDK and cygwin) you used to do the right

I used our own CDK,  see  http://www.denx.de/solutions-en.html#CDK  I
know  that  PPCBoot also compiles fine with the MontaVista CDK, and I
don't expect any problems with any of the other cross compilers.

And not to forget: PPCBoot compiles fine on a native  PPC  system  as
well.

> thing. Of course, other corresponding advice is
> welcome too. If you don¡¯t, please tell me your

I have some VERY IMPORTANT advice:

DO NOT TRY to compile ppcboot-0.4.4-pre1 or ppcboot-0.6.2. You better
remove all related files from your harddisks.

I cannot understand why people start with OLD versions  of  something
when there are newer, much improved versions available.

Summary: Please use ppcboot-0.7.3 and no older version.


> 2. Now my board have already had a ppcboot.srec on its
> flash, and I can download a kernel with Srec format
> into my board. In a word, everything is OK, since

But you should upgrade to a newer version of PPCBoot.

> mounting NFS is no problem, debugging simple
> applications on the board is also no problem. But, I
> think, when we make this board become a product, we
> should not let the board work through mounting a NFS
> located in a Host machine. Because the board should
> run independent of a Host machine. So my question is
> how to make a file system on my board? I appreciate
> a-sentence-advice and detailed descriptions about this
> question.

Build the kernel to use a ramdisk image, and follow the advice in the
PPCBoot README; see especially the sections starting "Similar you can
build PPCBoot images from a 'ramdisk.image.gz' file when your  kernel
is intended to use an initial ramdisk ..." and "If you want to boot a
Linux kernel with initial ram disk ...".


Hey, I know that thew PPCBoot documentation is pretty  poor,  but  as
long  as people tend to ignore the little that I wrote I feel next to
zero motivation to write any more of it :-(

And please move futher discussion of PPCBoot questions to the PPCBoot
mailing list.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Old programmers never die, they just branch to a new address.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
