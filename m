MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: 440GX: mapping PCI address
Date: Thu, 22 Jul 2004 09:43:26 -0500
Message-ID: <45ABD2373C33C4459D42B40EC4F346F2024CA461@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> /*
> * 36-bit trap ranges
> */
> #define PPC44x_IO_LO            0x40000000
> #define PPC44x_IO_HI            0x40001000
> #define PPC44x_PCICFG_LO        0x0ec00000
> #define PPC44x_PCICFG_HI        0x0ec7ffff
> #define PPC44x_PCIMEM_LO        0x80002000
> #define PPC44x_PCIMEM_HI        0xffffffff

> Hope this helps,
>  Gerhard


Indeed, I get a virtual address out of mmap
but my system freezes when I access it.
I try to access the PCI external configuration registers:

ptr=(unsigned int *)mmap(0, getpagesize(), PROT_READ | PROT_WRITE,
                             MAP_SHARED, fd, 0x0ec00000);


My kernel is 2.4.21 I would guess it should work from what I have seen regarding
messages about 36-bit address on 440GX.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
