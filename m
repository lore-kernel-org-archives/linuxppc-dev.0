Message-ID: <3B96BA46.6040604@ixiacom.com>
Date: Wed, 05 Sep 2001 16:50:30 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: dan@mvista.com
Subject: pthread support in ppc405 gdb
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The company I work for is porting a large, threaded C++ program to
proprietary ppc405-based hardware. We are using a custom in-house
toolchain I developed based on gcc 3.0.1 and the Montavista HHL 2.0
release--the gcc 2.95.3 release in HHL 2.0 lacks sufficient C++
support to build our codebase, which is primarily developed in
M$ Visual C++.

We have a mission-critical need for a ppc405 source level debugger
(gdb) which can handle complex, threaded C++ applications. However,
the HHL 2.0 release notes say the following:

* gdb 5.0
   gdb 5.0 included with HHL 2.0 does not support
   debugging multi-threaded (pthread) applications.

What are the problem areas that prevent gdb 5.0 from debugging
threaded applications on the ppc405? Is anyone on the
list or within MontaVista willing to work with me to fix
threading support in gdb?

We are willing to do whatever it takes to get x86-workstation-quality
gdb on the embedded ppc405 (and, tangentially, the sh4).

Thanks!

-Bryan

--
Bryan Rittmeyer
mailto:bryan@ixiacom.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
