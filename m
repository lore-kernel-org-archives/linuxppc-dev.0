Message-ID: <3A3F9363.1040105@galileo.co.il>
Date: Tue, 19 Dec 2000 18:57:07 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
Reply-To: rabeeh@galileo.co.il
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting the kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'v developed a network loader for our embedded systems that downloads a
kernel through network. Before branching to the kernel entry point
(logical address 0x0) I have I/D BAT2 already mapping 0xc0000000 to
0x00000000 . The problem is that the kernel hangs in lots of places in
arch/ppc/kernel/head.S file . For example all the mmu_off stuff ,
changing the BATs etc...

The question is what is the idial situation that the kernel will most
like ? What should be the situation of the BATs / MMU ?
What is initrd_start / end ? and what should I put in r4 / r5 ?

Any other piece of information provided might help bringing the boot
puzzle up !

Regards,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
