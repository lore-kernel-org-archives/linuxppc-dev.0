Message-ID: <3E24A7B5.7000500@redswitch.com>
Date: Tue, 14 Jan 2003 16:13:41 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: support@abatron.ch,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Debugging the kernel with BDI2000
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried to debug the kernel with BDI2000 and gdb and had some problems.

I wanted to set a breakpoint at console_init() and did the following steps.
(1) BDI>bi 0xc00020f0    # stop at start_here
(2) BDI>go
ppcboot was running and loaded the kernel image and stoped at start_here.
(3) BDI>ci
(4) ppc_8xx-gdb vmlinux    # start gdb
(gdb) target remote bdi:2001
(gdb) b console_init

The above steps were all successful. But when I wanted to step by 'n' or
continue the execution by 'cont'. I got the following error.

(gdb) cont
warning: Cannot insert breakpoint -1:
Error accessing memory address 0xc0000000: Unknown error 4294967295.

What does this mean? My BDI2000 configuration may not right? CPU is 855.

Thanks.
- shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
