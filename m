Date: Wed, 12 Jan 2000 10:35:01 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Pravin Pathak <pkpathak@dnrc.bell-labs.com>
cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Need Help
In-Reply-To: <387A333B.9CA93FF@dnrc.bell-labs.com>
Message-ID: <Pine.HPX.4.10.10001121032080.20852-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




On Mon, 10 Jan 2000, Pravin Pathak wrote:

> 
> Hi,
> I need to port Linux on our hardware with
> 603e processor and cpc700 MMU. There is no disk support.
> We do have flash ROM and ethernet on board.
> Can anyone suggest a site I can download this port OR
> a close match ?

You might want to see if my patches for MVME2600 and especially the
bootloader part in arch/ppc/prepboot help. They are available at 

	ftp://vlab1.iram.es/pub/linux-2.2/

you will still need to perform the early setup of the CPC700, modify
the UART address etc...but the code includes things like PCI resource
allocation and is flexible enough to be adapted to a variety of PCI I/O
base addresses, memory offsets etc...

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
