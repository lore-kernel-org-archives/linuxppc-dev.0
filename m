Message-ID: <3727A7E3.D379E041@zg.tel.hr>
Date: Thu, 29 Apr 1999 02:29:25 +0200
From: Stanko Juzbasic <stanko.juzbasic@zg.tel.hr>
Reply-To: stanko.juzbasic@zg.tel.hr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Lesstif problems
References: <199904281402.JAA31866@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Hi,

I am using lesstif-087 for porting some SGI & LinuxX86 academic music software to

LinuxPPC. There is a bit of problem, probably due to myself, being novice to
LinuxPPC programming. Main window does not appear correctly, l/r scrollbar
gets stuck under the menubar, the bottom of the u/d scrollbar gets hidden be-
low the resize corner. Resize itself does not work correctly (every odd time
I do resize work area collapses, on even resizes it miraculosly reappears).
Compiler gcc often gives weird warnings about
XtUnmanageChild being an incompatible pointer to XtAddCallback argument no. 3,
complains about missing callback lists when in fact they are not needed.


For test I compiled all the demo apps from Motif programming manual, which
exactly reproduces the problem. Furthermore the programs don't accept
user-defined default fonts, geometry & colors.

Hardware: PMac 7200
Kernels:   2.2.1,  2.1.127,  2.1.24
(2.1.24 of R4 does nor support but .WAV soundfiles, so I can't use it)

Although I did not get any dependancy warnings on other libraries, I would kindly

ask someone to whom this kind of problem sounds familiar which versions of
lXm lXt lICE lSM ...

do work with lesstif 0.87.

Thanks in advance.

Stanko



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
