Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD43622.A1D260B6@esd-electronics.com>
Date: Mon, 22 Oct 2001 17:07:14 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: filesystem for battery-buffered SRAM
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have to setup an embedded Linux box that uses 1MB of battery buffered
SRAM to store nonvolatile data.
This memory is directly mapped into addressspace and needs no magic
things to read or write to it.

What might be the best choice for a filesystem and how can I setup a
ramdisk
at a special memory location ?
Is MTD able to access normal RAM devices (no FLASH, but SRAM) ?

Matthias


--
--------------------------------------------------------------------------

                             _/_/_/_/   Matthias Fuchs
                            _/_/_/_/   Dipl.-Ing.
                           _/_/_/_/   matthias.fuchs@esd-electronics.com

       _/_/_/   _/_/_/_/_/_/_/      esd electronic system design gmbh
     _/   _/  _/             _/    Vahrenwalder Str. 207
    _/   _/    _/_/_/   _/   _/   D-30165 Hannover
    _/             _/  _/   _/   Phone: +49-511-37298-0
     _/_/_/_/_/_/_/   _/_/_/    Fax:   +49-511-37298-68

--------------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
