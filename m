From: "Kevin P. Dankwardt" <k@kcomputing.com>
To: <arun@ossi.co.in>, <penguinppc-team@lists.penguinppc.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Context Switch in Real Time  Linux Vs VxWorks (or any other RTOS)
Date: Fri, 16 Jul 2004 07:12:59 -0500
Message-ID: <KCEOLLHGFJIAFNAMGACHIECKDPAA.k@kcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <000001c46af2$642f7c40$e100a8c0@arunprasad>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There are a number of approaches to real-time in Linux. There are also
several different task/thread/process models from which to choose. Some
involve kernel space and some allow for user space. Some are open source and
some are proprietary. One has to decide on a number of factors before
choosing the solution best suited.

If you are comfortable with the flat memory model of VxWorks then a kernel
space solution may be acceptable. Kernel space solutions such as RTAI have
quite low "context switch" and quite fast interrupt response time.

For more information I'd recommend starting by reading (my) articles from
Embedded Linux Journal:

http://www.linuxdevices.com/articles/AT5997007602.html
http://www.linuxdevices.com/articles/AT5503476267.html
http://www.linuxdevices.com/articles/AT6320079446.html

Best of luck,
Kevin Dankwardt




>I'd like to compare the features of Linux and VxWorks with respect to the
>Real Time capabilities. I am little concerned about Linux's Context
>Switching.

>I'd like to get your opinion on this. Even if I want to move to Linux, I'll
>have to convince my management. So, any pointers on comparison of Linux Vs
>VxWorks with respect to Real Time capabilities would be highly appreciated.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
