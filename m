Message-ID: <40F77AA3.8030703@fh-landshut.de>
Date: Fri, 16 Jul 2004 08:50:11 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: arun@ossi.co.in
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Context Switch in Real Time  Linux Vs VxWorks (or any other RTOS)
References: <000001c46af2$642f7c40$e100a8c0@arunprasad>
In-Reply-To: <000001c46af2$642f7c40$e100a8c0@arunprasad>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arun Prasad Velu wrote:
>
>I am in the process of analyzing the feasibility of migrating an
>existing VxWorks system (MPC860 target) to Linux (RTOS).
>
>I'd like to compare the features of Linux and VxWorks with respect to
>the Real Time capabilities. I am little concerned about Linux's Context
>Switching.
>
>I'd like to get your opinion on this. Even if I want to move to Linux,
>I'll have to convince my management. So, any pointers on comparison of
>Linux Vs VxWorks with respect to Real Time capabilities would be highly
>appreciated.

I hardly guess context switching will be your main problem, because the
stock Linux kernel does not support hard realtime!

You either have to use RTAI (free kernel modification that requires
drivers to be rewritten for realtime), RTLinux (nearly the same,
non-free, patented) or modified Linux kernels from TimeSys or MontaVista
(who both add real-time capabilities in a more stock-Linux-compliant way).

Depending on your target, eCos (a free embedded operating system with a
focus on minimal code) may be the better choice for you, especially if
your platform is already supported.

Be warned: Not all PowerPC processors are supported in eCos (last time I
checked 74xx and 7xx were missing).

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
