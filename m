Date: Wed, 14 Jul 2004 18:40:22 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Unhandled interrupt in kernel/irq.c
Message-ID: <Pine.LNX.4.58.0407141828380.9591@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

 I'm trying to get 2.6 running on an AmigaOne.  Picking through the log
after it ran for maybe a minute, trying to work out which of the
messages matter.  I can't work out if this one is important.  The disk
i/o is working (well, PIO is), but the 'disabled' worries me :

for ide0 I see

Unhandled interrupt e, disabled

but then comes

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

and similar messages for ide1 interrupt f, 0x170+, irq 15.

The first message comes after ppc_spurious_interrupts has been
incremented, but the ide detail shortly after suggests maybe I don't
need to worry about it ?

Sorry if this is a stupid question.

Ken
--
 das eine Mal als Tragödie, das andere Mal als Farce


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
