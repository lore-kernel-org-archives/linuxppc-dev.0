Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FA8A251.40703@il.marvell.com>
Date: Wed, 05 Nov 2003 09:10:09 +0200
From: Ronen Shitrit <rshitrit@il.marvell.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: boot linux_ppc_2_4
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have a U-Boot which is working just fine,
and I'm trying to boot a kernel(ver 2.4) image with it ,
after I load the uImage to the DRAM by using the tftp as it is described
in the README file, I'm doing bootm to the uImage location,
I see that the code is getting to the kernel code , but there it get lost
after we disable the MMU in head.S.

(I know that the kernel version I have should be stable on my board
cause with the DINK monitor
I can load it just fine.)

Are there any special changes I should make to the Kernel in order for
it to be able to boot from the U-Boot??
If so, where can I find a good reference for it??

Thanks a lot

--
Ronen Shitrit

M.S.I.L
D.N. Misgav  20184
Tel:   +972-4-9951000
Fax:   +972-4-9951001
Email: mailto: ronen.shitrit@il.marvell.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
