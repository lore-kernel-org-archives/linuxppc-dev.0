Message-Id: <200011211708.eALH8h821293@denx.local.net>
To: "qiuqingjun" <qiuqingjun@263.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Ppcboot-users] How to add gcc parameters of application program in embedded system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Nov 2000 08:55:11 +0800."
             <001f01c05355$b4e05460$254a63ca@qqj>
Date: Tue, 21 Nov 2000 18:08:43 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <001f01c05355$b4e05460$254a63ca@qqj> you wrote:
>
> Thank Wolfgang Denk , I am not using PPCBOOT , my rom loader get from
> a friend in Motorola, the program can run on PPC823-FADS Board, I
> want to change the program for my custom board.

Please, then let's take this discussion out of  the  PPCBoot  mailing
list. A much better place for this sort of questions is
linuxppc-dev@lists.linuxppc.org

> you said ," build a new ramdisk image from scratch which then at
> least has a consistent set of shared libraries. " , How to build
> ramdisk image ? How to choose shared libraires to ramdisk image,which
> files should add in it? I find the file libc.so.6 about 4MB, so large
> that I cannot add it into ramdisk image.

Well, all these are basic steps of building Embedded  Linux  systems.
There  is  lots  of information about this in many mailing lists, for
instance the excellent "Linux for PowerPC Embedded  Systems  HOWTO  /
FAQ", see http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

> Additional , If I still cannot reach correct result, I would like to
> change my mind. I have to download PPCBOOT and rebuild my cross
> environment . Would you mind recommending some web site for build
> cross environment ? Which version of PPCBOOT is reliable? and Which
> web site contains linux for embedded system source code which doest
> not need more patches?

There are too many companies offering Embedded Linux solutions; check
for instance MontaVista (Hard Hat  Linux)  or  Lynuxworks  (Blue  Cat
Linux)  or  RedHat (Embedded Toolkit). I am sorry, I am not in a good
position to make recommendations here, since I'm obviously biased (we
too sell a Cross Development Kit on CD-ROM).

I cannot answer where to find kernel sources that don't need  patches
-  for  the  supported  systems, proably all systems come with kernel
versions that run out of the  box.  But  they  do  support  different
hardware  -  so you have to find one which supports something that is
as close as possible to the hardware you have.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If I have seen further it is by standing on the shoulders of  giants.
              - Isaac Newton, Letter to Robert Hooke, 5 February 1676

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
