Return-Path: <sanalvk@centillium.com>
Received: from ns2.centillium.com (mxout.centillium.com [12.47.55.9])
	by ozlabs.org (Postfix) with ESMTP id 50F55DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 May 2008 22:06:54 +1000 (EST)
Received: from callisto.centillium_nt.centillium.com (unknown [172.16.2.77])
	by ns2.centillium.com (Postfix) with ESMTP id AC45918F275
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 May 2008 04:26:39 -0700 (PDT)
Message-ID: <4822E5CE.3090701@centillium.com>
Date: Thu, 08 May 2008 17:06:46 +0530
From: Sanal Kumar V K <sanalvk@centillium.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Running a section of code from internal memory
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am porting a GW/router application to embedded Linux for a product
based on SoC; following is the version information:

kernel: 2.6.10
uClibc: 0.9.27
gcc: 3.4.3
binutils: 2.15.94.0.2.2

A small part of the code needs to run from the on-chip "L2 scratch" for
getting optimum performance. I would really appreciate if some could
give me some pointers regarding the following questions:

1. Is #pragma section supported by gcc.
The compiler prints this warning "ignoring #pragma section" and the
pragma is ignored indicating that it is not supported. Is there any way
I can get the pragma working for gcc or any alternative?

2. Is there any patch available to modify the kernel thread creation so
as to place the stack and tcb in the user configured addresses for
kernel threads (similar to taskInit() in VxWorks)?

Thanks in advance,
Sanal
