Message-ID: <20010110060652.49687.qmail@web11702.mail.yahoo.com>
Date: Wed, 10 Jan 2001 14:06:52 +0800 (CST)
From: Micael balow <micaelbalow@yahoo.com.cn>
Subject: New ppcboot Questions
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear sir,
  I'd like to ask you which compiler you used to
compile ppcboot-0.4.4-pre1 package in order to get a
working ppcboot.srec file.Some one advise me to use
CDK 1.2.
  But after I finished reading the manual of CDK 1.2,
I found that, CDK 1.2 is a Cross Development Kit for
Host-Target systems. What I really need is a just a
Compiling Environment, since I my goal is to make a
zImage for my PBX823 board with a MPC823 CPU on it.
  I think, you must have the experiences in compiling
the ppcboot-0.4.4-pre1 package, so I¡¯d like to
discuss with you the error messages I met when I used
ppc_8xx-gcc as my compiler to make ppcboot.srec, which
is a rule in the ¡°Makefile¡± of the top-directory of
the ppcboot-0.4.4-pre1 package:

 >No rule to make vsprinf.c needed by vsprintf.o

Judging from this message, there is three
possibilities, first, ppc_8xx-gcc can not compile
vsprinf.c; second, this file(vsprinf.c) is not a
working file; last, the way I use CDK 1.2 is wrong.
What I think about this messages is Ture or False?
What is the correct answer? Can you give me a prompt?
Detailed descriptions are welcome. Thank you very
much.

      Best Regards
                         Micael Balow




--- "Zheng, Haifei" <haifei.zheng@intel.com> µÄÕýÎÄ£º>
Hi there,
>
> The steps you need to follow is actually stated in
> the manual - Hard Hat
> Linux Cross Development Kit.
> Chapter 4 - setting up and booting the Target.
> Chapter 5 - Configure the Host System.
>
> I think you should have these on the CD or even
> download it from the web.
> http://www.mvista.com/cdk1.2/
> <http://www.mvista.com/cdk1.2/>
>
> Good Luck.
>
> Zheng Haifei
>
> 	-----Original Message-----
> 	From:	Micael balow [SMTP:micaelbalow@yahoo.com.cn]
> 	Sent:	Monday, January 08, 2001 9:41 PM
> 	To:	haifei.zheng@intel.com
> 	Subject:	RE: ppcboot Questions
>
> 	Dear Zheng,
> 	     I use CDK 1.2 as my cross compiler.In fact,I
> am
> 	sorry to say,I don't know how to use CDK 1.2 to
> make
> 	ppcboot_0.4.4.pre1.
> 	     Would you like to give me a description of the
> 	steps that you took to compile ppcboot_0.4.4.pre1
> 	using CDK 1.2.
> 	     Other prompt information is also appreciated
> by
> 	me.Thank you in advance.
> 	     Best Regards
> 	                     Micael Balow
>
> 	--- "Zheng, Haifei" <haifei.zheng@intel.com> ???:>
> 	Hello,
> 	>
> 	> Could you please tell us what cross compiler you
> are
> 	> using? We suggest that
> 	> for out-of-box compiling you use the Monta Vista
> 	> Hardhat Linux distribution.
> 	> http://www.mvista.com/cdk1.2/
> 	> <http://www.mvista.com/cdk1.2/>
> 	> You can look in the on-line Hard Hat Linux CDK
> 1.2
> 	> manual to see if they
> 	> support your board.
> 	>
> 	> Good Luck.
> 	>
> 	>
> 	> Haifei Zheng
> 	>
> 	> 	-----Original Message-----
> 	> 	From:	Micael balow
> [SMTP:micaelbalow@yahoo.com.cn]
> 	> 	Sent:	Friday, January 05, 2001 6:20 PM
> 	> 	To:	linuxppc-embedded@lists.linuxppc.org
> 	> 	Subject:	ppcboot Questions
> 	>
> 	>
> 	> 	Dear Sir,
> 	> 	      I am a freshman of the development of
> 	> embedded
> 	> 	system, and it is my honor to contact with you .
> 	> 	      I have already had a custom PBX board with
> a
> 	> 	embedded CPU named MPC823, and a monitor has
> 	> already
> 	> 	been flashed into a EPROM on the board.
> 	> 	      I'd like to ask you the following
> questions.
> 	> 	      1.I think,in order to get a kernel image
> and
> 	> let
> 	> 	it run on that board,I need a Linux OS with a
> right
> 	> 	version to complie a kernel. When I used Redhat
> 6.0
> 	> 	and 6.1 Linux to make ppcboot.0.4.4-pre1,I got
> the
> 	> 	following error mesages:
> 	>
> 	> 	>      Makefile:24:***unterminated call to
> 	> >function
> 	> 	'shell' : missing '('. stop.
> 	>
> 	> 	     But when I use Redhat 6.2 Linux to make
> 	> 	ppcboot.0.4.4-pre1,the message is something like
> 	> the
> 	> 	following:
> 	>
> 	> 	>Make[1]:Entering directory '/ppcboot/ppc'
> 	> 	>Make[1]:'.depend' is up to date.
> 	> 	            ...
> 	> 	>Make[1]:Entering directory '/ppcboot/tools'
> 	> 	>Make[1]:***No rule to make target
> 'crc32.c'needed
> 	> >by
> 	> 	'.depend'. stop.
> 	> 	>Make[1]:Leaving directory '/ppcboot/tools'
> 	>
> 	> 	     I do not  know the reason that I got so
> much
> 	> 	error messages.Did I use the wrong Linux
> version?
> 	> Did
> 	> 	I use the wrong Bash version? How can I make
> 	> changes
> 	> 	to let it run well.
> 	>
> 	> 	     Thank you for your reading my letter and
> thank
> 	> 	you for your considering my questions. I'd like
> to
> 	> 	expect to get answers as soon as possible. Thank
> 	> you
> 	> 	very much.
> 	>
> 	> 	      Best Regards
> 	>
> 	> 	                      yours sincerely  Micael
> Balow
> 	>
> 	>
> 	>
> 	>
>
>
_________________________________________________________
> 	> 	Do You Yahoo!? ????????!
> http://mail.yahoo.com.cn
> 	> 	???????,???????!http://cn.clubs.yahoo.com
> 	>
> 	> 	** Sent via the linuxppc-embedded mail list. See
> 	> http://lists.linuxppc.org/
> 	>
> 	>
>
>
>
>
_________________________________________________________
> 	Do You Yahoo!? ????????! http://mail.yahoo.com.cn
> 	???????,???????!http://cn.clubs.yahoo.com
>
> .
> __________________________
> 	Do You Yahoo!? ????????! http://mail.yahoo.com.cn
> 	???????,???????!http://cn.clubs.yahoo.com
>
> .
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
