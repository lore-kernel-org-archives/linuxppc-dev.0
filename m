Message-ID: <389B7295.B782832F@netx4.com>
Date: Fri, 04 Feb 2000 19:45:09 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Olivier DERVYN <dervyn@digigram.com>
CC: Linux PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux PPC on Sandpoint or YellowKnife board with 750
References: <200002031505.HAA04494@berkeley.innomedia.com> <389A8104.AC2C196D@jlc.net> <389A8D76.4E667E17@digigram.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Olivier DERVYN wrote:


> What is your dev. platform (compiler, JTAG probe and board architecture)
> ?


All of my development hosts are Macintosh (iMac, iMac DV,
PowerBook, G4 server) running Linux/PPC.

No JTAG or BDM necessary as I am using the ROM on the board (DINK).


> What kind of problem stop you ?

Time and money.


> I have two sandpoint one with 750+107 and other with 8240, which is your
> board ?

8240.


> Do you have used other OS on this board ? (as RTOS or other)

No.


Motorola gave me the 8240/Sandpoint to develop the kernel.  I
spent a few weeks of my own time, have a system booting with
root NFS (PCI Ethernet), ran Apache and some other tests.  I
never had the 8259 interrupts working correctly with the
OpenPIC on the 8240.  I gave the code to MontaVista to continue
the development.  Depending upon the time available, I will either
check in what I have or wait for MontaVista to fix it and then
check it in.

The problem with the Sandpoint is we need a better boot rom
to support Linux/PPC.  Their standard DINK only supports S-record
download over the serial port.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
