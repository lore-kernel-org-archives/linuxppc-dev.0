Message-ID: <1072F1A27E99D3119747005004B9A380BF28A0@MAIL>
From: Brett Carswell <BrettC@nulec.com.au>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RPX Lite w MontaVista 1.2
Date: Thu, 14 Dec 2000 18:10:14 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have downloaded the MontaVista CDK 1.2 and installed everything for the
RPX lite. I followed the documentation and I can load the s record image
into an RPX Lite board (850SR) using tftp no problem - I did a memory dump
and the first few bytes match the srec file. When I type go 200000 to try to
start the kernel the board just goes off with the fairies. I enabled the bus
monitor and the board resets so I assume it's accessing memory outside of
what's configured. The RPX lite is running the PlanetCore Boot Loader v1.01.
Here are the keys for the RPX lite :

Baud                                   = 9600
Multiplier  (Clock multiplier)         = 6
Board                                  = LICC_E
Revision                               = BW
Processor                              = 850
Variant                                = SR
DRam        (MBytes on board dram)     = 16
Cols        (On board dram columns)    = 10
NVRam       (KBytes on board NV Ram)   = 0
Sttm        (Degrees C*10)             = 131
Twirl                                  = Y
ICache                                 = N
SYPCR                                  = FFFFF080
RAMtest                                = Y
RestoreCE   (Cannot go to ram if set)  = N
SerOut      (Serial output of loader)  = Always
RS232       (Enable rs232 drivers)     = Y
IP                                     = 192.168.0.122
Target                                 = 192.168.0.89
File                                   = zImage
ENET                                   = 0010EC000DB4
TftpRAM                                = High
Start                                  = 0
Format                                 = NetSrec
Autoboot                               = N

The memory map is
IMMR = 0xFA200000
    Address  Mask     Size WP Mach
CS0 FC000000 FC000000 Word N  GPCM
CS1 00000000 FF000000 Word N  UPMA
CS2 (not used)
CS3 FA400000 FF7F8000 Word N  GPCM
CS4 (not used)
CS5 (not used)
CS6 (not used)
CS7 (not used)

Any help would be appreciated.

Thanks in advance,
Brett Carswell
Nu-Lec Industries  (ACN 085 972 425)
35-37 South Street, Lytton, Brisbane, Qld, 4178, Australia
PO Box 761, Wynnum, Qld, 4178, Australia
Direct Dial Phone No:	+61 7 3249 5498
Switchboard Phone No:	+61 7 3249 5444
Facsimile No:		+61 7 3249 5888
Email Address:		BrettC@nulec.com.au
World Wide Web Site:	http://www.nulec.com.au


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
