Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040813052042.77792.qmail@web53703.mail.yahoo.com>
Date: Thu, 12 Aug 2004 22:20:42 -0700 (PDT)
From: Junita Ajith <junita_ppc@yahoo.com>
Subject: How to  boot U-Boot from RAM 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am trying to have a different version of UBoot with some utilities
added to it. So I'm trying to figure out a way to check if that upgraded
version of UBoot works fine, without copying it to the default location
where my original UBoot resides in the flash. I am using a 8540 board.

   I changed the linker file u-boot.lds, by mapping it all to RAM
locations. When I compiled it, I could get the final U-Boot image
u-boot.bin of size 154KB.

  I tried to tftp to 0x2000000 of RAM and said go, it hangs (always I
have acopy of the working UBoot image in my default Flash location).

The disassembly of both the UBoot images seems to be the same, except
that in the binary I couldn't see the image header in a readable for the
upgraded image, where as I could see that for the original U-Boot.

I guess may be as the original u-boot has intialised the ports..TLBs
etc, it clashes. I am not sure but...

     All I need to know is how do we run the UBoot from RAM, without
using flash. Any help would be appreciated.

Thanks
Junita

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
