From: Christian =?iso-8859-1?q?Tr=F6ster?= <c.troester@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board
Date: Fri, 2 Apr 2004 23:40:44 +0200
References: <1866383.1080909296@[192.168.0.230]> <5357473.1080912787@[192.168.0.230]>
In-Reply-To: <5357473.1080912787@[192.168.0.230]>
MIME-Version: 1.0
Message-Id: <200404022340.44604.c.troester@gmx.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Am Friday 02 April 2004 20:33 schrieb Jeff Tucker:
> I've re-built U-Boot in debug mode so I can see what is going on. Here's
> what it spits out before the board locks up:
[snip]
> procfreq    = 266.666 MHz
> plb_busfreq = 133.333 MHz
> pci_busfreq = 33.333 MHz
> ethaddr     = 00:04:AC:E3:24:A7
> IP addr     = 192.168.0.91
> baudrate    =   9600 bps
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
>
> Any ideas?
If you're connected via a serial console make sure to append the correct
bootoptions to the kernel to get your output to /dev/ttySx.

Bye, Christian

- --
| mailto:c.troester@gmx.de | http://www.christian.myfen.de/ |

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
