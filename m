Message-Id: <200402010719.BAA05399@lists.linuxppc.org>
Date: Sun, 1 Feb 2004 15:17:15 +0800
From: "sun-zj" <sun-zj@tdk-tech.com>
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: "sun-zj" <sun-zj@tdk-tech.com>
Subject: eth0 memory sqeeze
Content-Type: text/plain
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, denk:
I am using the Linux On MPC860T as your instructions. Now I want to do a
performance test
of PPC with linux. Our board is FADS and MPC860T.
I use the kernel from denx website(2.4.4). the test
program is iperf.
When I use the iperf on PPC+linux as server, I start the iperf on PC as
client. I choose the options -n 300M -P 120 which mean I want to open 120
threads each one open a TCP connection and each preparing to send 300MB
data. On PPC+linux I get the  following output.
"eth0: Memory squeeze,dropping packet"
"__alloc_pages: 0-order allocation failed (gfp=0x20/0)
I guess that the data to be processed exceeds the capabilities of PPC+linux.
I wonder whether this could be solved by Linux ???
Thanks a lot for your kind help
Best Regards.

Zongjun Sun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
