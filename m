Message-ID: <D73A25AA6E54D511AD74009027B1110F3C080C@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Andrew H Pham'" <apham@us.ibm.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Start address for ICE Planet, EP405PC
Date: Mon, 28 Apr 2003 09:23:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are using an srec or binary file then the start address is the same
as the one you load to.  If you are using an elf file the start address is
the load address + 0x10000.

-----Original Message-----
From: Andrew H Pham [mailto:apham@us.ibm.com]
Sent: Friday, April 25, 2003 6:01 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Start address for ICE Planet, EP405PC



Hi,

I am trying to tftp load a kernel image into memory and boot it; however, I
don't know what address to set the Start variable to.
Start is the address where the boot loader goes to and executes when you
issues the "go" command using the boot loader v1.03
In another the word, does anyone know what is the offset is for the ppc
kernel?  Let say the image is stored starting at address 200000,
what address should i jump to so execution can begin (200???)?

Thanks in advance for any help,
Andy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
