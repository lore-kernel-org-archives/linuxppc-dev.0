Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45028B291@NTSERVER4>
From: Phil Thompson <philt@4bridgeworks.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: What Bootloader Initialisation does the PPC Kernel Expect?
Date: Thu, 1 Apr 2004 16:58:32 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am porting the latest 2.4 kernel to a 405GP based board (using the Walnut
port as a reference). The bootloader is in-house code with minimal
functionality.

The kernel gets as far as displaying the "Now booting the kernel" message.
The actual line of code at which the kernel "disappears" is the "rfi"
instruction (in ppc/kernel/head_4xx.S) that is supposed to transfer control
to the "start_here" label, ie. when the MMU is enabled.

By this time, the kernel has executed very little board specific code, so
I'm thinking that the problem is that the bootloader might not be doing some
initialisation that the kernel is expecting.

Are there things that the kernel expects the bootloader to have done
(ignoring obvious things like setting up the memory controller)? Does the
above problem suggest anything in particular?

Many thanks,
Phil

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
