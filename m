From: bigmouth@pionet.net
Message-Id: <200102202011.OAA10317@mail1.pionet.net>
Subject: PCI allocation
To: linuxppc-dev@lists.linuxppc.org
Content-type: text/plain
Mime-version: 1.0
Date: Tue, 20 Feb 2001 14:11 +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently working on trying to figure out why my adaptec 3950 is not being initialized by the computer on a 2.2 stock kernel (can't get any other kernel to not mess up my keyboard yet).  Is there something I can do without starting in on the 2.4 tree yet?


> >The problem isn't that the driver is detecting that the BIOS wasn't run, the
> >driver is detecting that the cards IRQ or I/O space allocations haven't been
> >performed. Without those allocations being made, the card can't be used
>
> OK that makes sense. But why hasn't it? Isn't PCI supposed to do that automagically? Is there a way I can force it to do it?
The BIOS on the motherboard is suppossed to take care of that, and it
obviously hasn't. Why, I have no clue. I don't own any PowerPC machines so I
don't know how their BIOS operates. The latest 2.4 kernel might work since
the hot plug PCI feature might go ahead and allocate space for the card where
the 2.2 kernel series PCI infrastructure won't.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
