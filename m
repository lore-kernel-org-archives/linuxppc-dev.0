Message-ID: <384FC958.590A4C65@iname.com>
Date: Thu, 09 Dec 1999 15:23:04 +0000
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: Ilya Gindentuller <igin@vrcomm.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What are the best cross-development tools to build Linux for MPC860,
 kernel ver. 2.2.13 or later?
References: <000901bf4277$a7c043c0$65daa8c0@vrcomm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bright Star Engineering BSE (www.brightstareng.com) sell a SDK with
their boards for x86 linux or windows 9x/NT hosts. The latter uses the
cygnus toolkit. Whilst these tools are great for cross-compiling the
linux kernel on x86 win32 hosts, you quickly find that that's the least
of your worries; you will probably need to build "user" applications for
the 8xx too (unless you use standard linuxPPC tools with kernel FPU
emulation). The BSE SDK includes many such user apps, such as ftpd,
httpd, sh etc but you are sure to want other linux goodies that they
don't provide. To build such tools in the cygnus environment on win32
hosts is much harder than on x86 linux hosts. On linuxPPC hosts, it is
almost trivial to rebuild those apps for the 8xx, hence some of us like
a linuxPPC machine for embedded PPC linux work.

I recommend you set up one of your win32 machines as a dual-boot
win32/linux box and go from there. The best way to learn about linux is
to use it.

Ilya Gindentuller wrote:
> 
> Hi, everybody!
> 
> We are complete novices in Linux development and want to learn how to use
> Linux on MPC860.
> So, please help us out since we are stuck with so many choices and versions
> floating around.
> 
> I found Linux port for MPC860 ver.2.2.13 (in the ftp section of
> www.ppc.kernel.org) and I want
> to build it (as is) to run on our EST board.
> 
> We have to do cross-development under Windows 98/NT.
> I searched mailing lists and it looks that everybody is using native Linux
> (MAC) machines
> to do development - no cross-development environment.
> 
> Please, could somebody direct us to the best source of embedded Linux
> cross-development tools that we
> can use on Windows 98/NT x86 machine to generate code for MPC860 EST board?
> 
> All input and instructions are welcome and greatly appreciated.
> 
> Thanks in advance,
>                                 Ilya Gindentuller

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
