Message-ID: <001201c1d80e$57e12840$479b883e@m5axc>
Reply-To: "Neil Wilson" <nwilsn@airspan.com>
From: "Neil Wilson" <nwilson@airspan.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: forcing pci device start address ? 
Date: Sat, 30 Mar 2002 17:14:24 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We have a new 7450/107 board that I have got to boot and run 2.4.17.  The
hardware designer has got some non-standard pci devices ie, a large fpga
 that lives in pci space but does not have a configuration register and also
 some standard pci devices like the AMD79C973 ethernet controller.

 Is it possible to force the start address for the devices to be at specific
 addresses as determined by the hardware map using the existing pci
 controller code ?  An example is the ethernet controller which is at
 0xe0000000 in the hardware map yet when it it is detected during the pci
 probing the pcnet32 driver has its ioaddr set to somewhere like 0xfbeffxxx.


I am looking through the other setups in the platforms directory and trying
 to search the archives but this pci is all a bit of a mystery to me a the
 momment.

 Thanks for any help/comments.

 Neil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
