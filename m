From: "Ramzi Maalouf" <maalouf@pyxsys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: does the scsi module work w/Hardhat 2.4.2 on a 405gp
Date: Wed, 21 Mar 2001 12:32:20 -0500
Message-ID: <HLEMJIMPGFPIGKHADMOIAEMLCAAA.maalouf@pyxsys.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C0B202.F955C380"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C0B202.F955C380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


hello -

	Has anyone got the scsi module to work with 1010_66 chip set on a walnut
405gp running HardHat linux (kernel 2.4.2).
I get error output no matter what combination of switches i try.
the system: walnut 405gp, hardhat linux (kernel 2.4.2-010303), symbios scsi
controller chip set sym53c1010_66, attached to a raid-5.

-ramzi

sh-2.03# insmod scsi_mod.o
SCSI subsystem driver Revision: 1.00
sh-2.03# insmod sd_mod.o
sh-2.03# insmod sym53c8xx.o
sym53c8xx: at PCI bus 0, device 4, function 0
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c1010_66 detected
sym53c8xx: at PCI bus 0, device 4, function 1
sym53c8xx: setting PCI_COMMAND_IO PCI_COMMAND_MEMORY...
sym53c8xx: setting PCI_COMMAND_MASTER PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: changing PCI_LATENCY_TIMER from 0 to 80.
sym53c8xx: 53c1010_66 detected
sym53c1010_66-0: rev 0x1 on pci bus 0 device 4 function 0 irq 31
sym53c1010_66-0: ID 7, Fast-80, Parity Checking
CACHE TEST FAILED: script execution failed.
start=000005d8, pc=000005e0, end=000005f8
CACHE INCORRECTLY CONFIGURED.
sym53c1010_66-0: giving up ...
sym53c1010_66-0: rev 0x1 on pci bus 0 device 4 function 1 irq 31
sym53c1010_66-0: ID 7, Fast-80, Parity Checking
sym53c1010_66-0: on-chip RAM at 0x80002000
CACHE TEST FAILED: script execution failed.
start=000005d8, pc=000005e0, end=000005f8
CACHE INCORRECTLY CONFIGURED.
sym53c1010_66-0: giving up ...
sym53c8xx.o: init_module: No such device





****
This message is from Pyxsys Corporation and may contain
confidential business information. It is intended for the addressee
only and may not be copied without our permission. If you are not
the intended recipient please contact the sender as soon as possible.
****

------=_NextPart_000_0002_01C0B202.F955C380
Content-Type: text/x-vcard;
	name="Ramzi Maalouf.vcf"
Content-Disposition: attachment;
	filename="Ramzi Maalouf.vcf"
Content-Transfer-Encoding: quoted-printable

BEGIN:VCARD
VERSION:2.1
N:Maalouf;Ramzi;;Mr.
FN:Ramzi Maalouf
ORG:Pyxsys
TITLE:Software Engineer
NOTE:{6}
TEL;WORK;VOICE:(978) 371-9115 x132
ADR;WORK:;;142Q North Rd;Sudbury;MA;01776;United States of America
LABEL;WORK;ENCODING=3DQUOTED-PRINTABLE:142Q North Rd=3D0D=3D0ASudbury, =
MA 01776=3D0D=3D0AUnited States of America
EMAIL;PREF;INTERNET:maalouf@pyxsys.net
REV:20010209T012709Z
END:VCARD

------=_NextPart_000_0002_01C0B202.F955C380--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
