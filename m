Message-Id: <200402070134.TAA20218@lists.linuxppc.org>
Date: Sat, 7 Feb 2004 9:31:54 +0800
From: "sun-zj" <sun-zj@tdk-tech.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: wd@denx.de
Reply-To: "sun-zj" <sun-zj@tdk-tech.com>
Subject: how to Compile linuxppc 2.5
Content-Type: text/plain
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
I am using linuxppc-2.4.pre2, it works fine. But now I have some questions.
My board is FADS and CPU is PPC860T(FEC ethernet). I test its' network
performance. When I send to much data to PPC+linux,the linux OS can't repond
any my input through serial. after some time, the login process is killed,
and I can't login anymore but I can ping it from other computer. what happen
to that??
second, I want to see whether the linuxppc_2.5 has some improvement for
that. so I download the linuxppc_2.5 from denx by BK Clone. But how can
extract the source files from BK's file?? Under the
linuxppc_2.5 how Can compile the kernel?? I compile the official kernel
2.6.2. It dones't know what I make(I use "make FADS_config" command and denx
cross toolchains)??

Thanks a lots for your instructions.

Best Regards.
Zongjun Sun

Bejing TDK Corp. Ltd
8610-82644933 ext:6210

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
