Date: Thu, 4 Jan 2001 09:37:10 +0530 (IST)
From: "Srinivas Rao.M" <msrao@vxl.co.in>
To: linuxppc-dev@lists.linuxppc.org
Subject: Critical section - pSOS+
In-Reply-To: <XFMail.20010103201404.gthomas@redhat.com>
Message-ID: <Pine.SCO.3.91.1010104092854.21798A-100000@vayudoot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to all,

 I am sorry, This question is not releated to the list directly.

 We have a custom board built using MPC860 processor and running the
pSOS+ kernel. We are running a multitasking application on this. we are
facing a problem with the critical section.
we have in pSOS+, splx(1) and splx(0) calls for disabling and enabling the
interrupts respectively. Having multiple tasks running on the kernel,
suppose if one task disables the interrupt by calling splx(1),
The other task can enable the interrupts back to the old posture by
calling splx(0). Hence the critical section code is left in the non
critical section area. Unlike UNIX, pSOS+ doesnot provide, the interrupts
locking (and unlocking) mechanism at the task level.
In such contexts how can we solve this problem.

Thanks in advance.
Srini...

--

The beginning of knowledge is the discovery of something we do not understand.
-Frank Herbert
(contributed by Chris Johnston)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
