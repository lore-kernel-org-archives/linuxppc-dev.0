Message-Id: <5.1.0.14.0.20010817160848.00abfec0@spudcentral.com>
Date: Fri, 17 Aug 2001 16:16:45 -0600
To: Mark Hatle <fray@mvista.com>,
	Mark Pilon <mark.pilon@minolta-qms.com>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: init fails w/ new build of gcc & glibc
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B7D9126.D9F7C302@mvista.com>
References: <3B7D82D5.DD98A109@minolta-qms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:48 PM 8/17/2001 -0500, Mark Hatle wrote:
>If the answer is that it is standard floating point then you can use the
>"7xx" or "82xx" tools for your project.  If you want to recompile then
>you need to recompile the whole system from the compilers up to glibc
>and all of the apps.  There are two ABIs, one for soft-floating point
>and one for hard floating point.  They are not run-time compatable.

Mark,

You mentioned these two exclusive ABIs a couple days ago. If you want to compile the toolchain and the kernel correctly to insure run-time compatibility (in my case for 8xx), would you do this

for kernel fp emulation
compile kernel with CONFIG_MATH_EMULATION=y, (do you use -msoft-float while compiling kernel?)
then compile the toolchain without -msoft-float

or

for soft-floating point - no kernel emulation
compile kernel CONFIG_MATH_EMULATION is not set (do you use -msoft-float while compiling kernel?)
then compile the toolchain with -msoft-float


Very very curious
Thanks
Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
