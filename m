Return-Path: <fabidi@ultsol.com>
Received: from rwcrmhc13.comcast.net (unknown [216.148.227.153])
	by ozlabs.org (Postfix) with ESMTP id BF26C68A25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 05:43:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Gdb with MPC85xx
Date: Fri, 3 Feb 2006 13:41:29 -0500
Message-ID: <81C69D96BDD30640952C7A404004AA2501954E@ultsol01.tewks.ultsol.local>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am wondering if someone here is using GDB to debug code on an 85xx
platform with the BDI. I have been running into several issues with GDB
5.x and 6.x where the E500 core does not seem to either step properly to
the next line of code in the kernel or uboot or gets lost altogether.
Each version of GDB seems to have its own set of bugs. If someone has
been using a version of GDB that works pretty well then let me know what
version it is and I can try and download it and build it and see if it
behaves better.

This is probably more of a tools question then a Linux question, I'm
hoping I can get an answer anyway.

Thanks,

Fahd
=20
