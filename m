Message-ID: <39578A84.7C685791@esd-electronics.com>
Date: Mon, 26 Jun 2000 18:53:24 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: using ISA interrupts on MBX821
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I want to get a driver for a PC ISA card running on the MBX board under
linux.
I am using Motorola's adapter board to interface the ISA card on the MBX
board. The driver is working fine
on x86 platforms. I can also communicate to the io registers on the ISA
card.

But ... I cannot get interrupts working. The ISA card uses irq 13
(others are possible), since this is free on the MBX.
What do I have to pass to the request_irq call as interrupt number ? Is
13 ok ?

Do I have to think about any other differences concerning the PPC
platform ?

Some infos: Linux kernel 2.2.13 from Monta-Vista, no PCI support present
in kernel because of the known bug in the QSPAN.

Can anybody give me some advice ? Do I have to think about something
special on my platform ?


Matthias


--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
