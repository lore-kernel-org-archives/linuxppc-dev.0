Date: Tue, 18 Apr 2000 20:20:53 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: prep interrupt routing
In-Reply-To: <38FB7B28.9DFFDBE1@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10004182018020.19933-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The PCI-ISA bridge is the "IBM Fire Coral" chip - does anybody actually
> have a part number for this chip so I can look it up on IBM's site?

Open your box and look at the chip ?

> Output from the above command:
> prozac:~# lspci -xxxsb.0
> 00:0b.0 ISA bridge: IBM Fire Coral (rev 02)
> 00: 14 10 0a 00 07 00 00 04 02 00 01 06 00 00 00 00
> 10: 01 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

Standard header, not much to say except for the 0xff which looks crazy.

> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Only one non zero bit in the whole device specific area. It does not look
like you can do much about interrupt routing if it's similar to
WinBond and Intel bridges.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
