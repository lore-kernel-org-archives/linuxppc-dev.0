Message-ID: <37D93727.49096696@chpc.utah.edu>
Date: Fri, 10 Sep 1999 10:51:51 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Content-Type: multipart/mixed;
 boundary="------------BAF6FD94C4EF410F4C243E50"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------BAF6FD94C4EF410F4C243E50
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I just posted this yesturday to the newsgroup and someone pointed out
that this list has discussed this problem before. After digging through
the archives it seems this issue is still unresolved but that a lot of
changes have been going into the 2.3 kernel that may improve this
situation. In the meantime, I'm hoping then someone can point out what
the difficulties are for fixing this and where I'd have to look.
Alternatively, tell me where a patch already exists for this ;-)

Thanks!!!

--------------BAF6FD94C4EF410F4C243E50
Content-Type: message/rfc822
Content-Disposition: inline

Delivered-To: ldl@eden.chpc.utah.edu
Received: from mrelay.inscc.utah.edu (mrelay.inscc.utah.edu [155.101.3.60])
	by eden.chpc.utah.edu (Delivermail) with ESMTP for <ldl@eden.chpc.utah.edu>
	id 99463105F1A; Thu,  9 Sep 1999 20:20:53 -0600 (MDT)
Received: from mail.inscc.utah.edu (mail.inscc.utah.edu [155.101.3.59])
	by mrelay.inscc.utah.edu (8.9.2/8.9.2) with ESMTP id UAA03468
	for <ldl@eden.chpc.utah.edu>; Thu, 9 Sep 1999 20:21:25 -0600 (MDT)
Received: from mrelay.inscc.utah.edu (mrelay.inscc.utah.ed [155.101.3.60]) by mail.inscc.utah.edu  with ESMTP id UAA07150 for <ldl@chpc.utah.edu>; Thu, 9 Sep 1999 20:20:28 -0600 (MDT)
Received: from eden.chpc.utah.edu (eden.chpc.utah.edu [155.101.3.151])
	by mrelay.inscc.utah.edu (8.9.2/8.9.2) with ESMTP id UAA03464
	for <ldl@chpc.utah.edu>; Thu, 9 Sep 1999 20:21:24 -0600 (MDT)
Received: from chpc.utah.edu (remote5.inscc.utah.edu [155.101.3.205])
	by eden.chpc.utah.edu (Delivermail) with ESMTP
	id CFF9B105F19; Thu,  9 Sep 1999 20:20:49 -0600 (MDT)
Sender: ldl@chpc.utah.edu
Message-ID: <37D86B96.84E580A6@chpc.utah.edu>
Date: Thu, 09 Sep 1999 20:23:18 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.12 ppc)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.powerpc
Cc: paulus@cs.anu.edu.au
Subject: Bug: 2.2.12 still hangs PPC after some PPP activity
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hoping someone can help with this bug...

I just recently compiled the 2.2.12 kernel on my LinuxPPC 1999 OS base
and still find the system hanging sometimes after some PPP activity. It
doesn't seem to happen as easily as earlier kernels but it's still
happening. This last time I was doing some telnet activity so it's
gotten a lot harder for me to believe Netscape does anything more than
tweak the problem (despite what others have reported about Netscape but
perhaps that a similar but seperate bug).

My system is a PowerMac 7500/100 with a 28.8 US Robotics modem. After a
few days my PPP connection drops from what I believe are hardware
problems at my ISP's end. I then restart the PPP connection using netcfg
and get back to work. Ussually after about three reconnects the next
time my PPP connection hoses, the system itself hangs shortly
there-after. As in nothing works, moves, lights up. Can't even switch
virtual console or see any of the keyboard LEDs light up. After I reboot
the system, there's no indication of what caused the hang in the
messages file nor would I suspect anything would have logged a problem
since its getting hung rather than crashing. I've tried with everything
I needed compiled into the kernel and I've tried kernels where most of
what I needed in my kernel that could get built as a module got built as
such. Nothing's helped but 2.2.12 doesn't seem as quick to get into this
hung state.

No one I know using Linux on an Intel box has had this sort of problem
so it would seem something specific to the PowerPC specific code and I'd
guess the bug's in the serial driver or the ppp driver except there
doesn't seem to be any PPC specific code in either of these. I tried
compiling with the SysReq hot key functionality but that didn't seem to
be supported properly for the PowerPC.

If anyone knows of a source patch to fix this, please pass it a long. If
anyone has any better ideas where this bug might be, please point those
kernel files out. If anyone just has some pretty good ideas for how to
debug the kernel code for this problem, even pass that on.

Thanks!


--------------BAF6FD94C4EF410F4C243E50--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
