Date: Sat, 14 Sep 2002 12:34:28 +0500 (GMT+0500)
From: Atm account <linux2@cdotd.ernet.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: help needed for porting linux-2.5 to a ppc custom board
Message-ID: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

  We want to run linux on a custom board having ppc603ev.
We have identified the following tasks :-
processor-specific tuning,
board related changes (io_block_mapping, pic etc.)
serial driver for uart device.
pci,timer initialisations.

  There is 4mb flash on the board (for storing vmlinux.gz)
No hard disk.

 Since, there is only 1 uart port, how can we use it for
console-login and dumping printk messages?

 How should we start identifying changes to be done in
kernel source (mostly arch/ppc)? Is there any resource
available on internet for porting linux to a powerpc/any
board ?


Regards & Thanks
Piyush

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
