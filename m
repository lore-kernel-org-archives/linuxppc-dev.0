Date: Sat, 24 Jul 1999 12:28:56 -0400 (EDT)
From: satadru pramanik <satadru@umich.edu>
To: rumors@macosrumors.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: interesting stuff from the ibook dev pdf
Message-ID: <Pine.LNX.4.10.9907241221310.19195-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The New World Roms support additional Open FirmWare drivers for booting
from USB AND FireWire, a byproduct of adding boot support for UDMA66

- -excerpts-
- --
USB Storage Devices 3 The Macintosh USB software supports booting from an
external USB storage device. Class drivers are software components that
are able to communicate with many USB devices of a particular kind. If the
appropriate class driver is present, any number of compliant devices can
be plugged in and start working immediately without the need to install
additional software. The Mac OS for the iBook includes USB Mass Storage
Support 1.3, a class driver that supports devices that meet the USB Mass
Storage Class specification. See USB Drivers (page 70).

On the iBook, the Open Firmware code has been extended so that the device
tree describes the new hardware features of the computer. The Open
Firmware code also includes FCode drivers for the new hardware channels:
UltraDMA66, FireWire, and USB.
- --

The document is at
http://developer.apple.com/techpubs/hardware/Developer_Notes/Macintosh_CPUs-G3/iBook/iBook.pdf


Imagine booting LinuxPPC via FireWire or USB on new Macs before you can
boot any *nix on other architectures. (Well... Ok, I suppose that the Mac
OS X Consumer Release might have it first.)




- --=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
MIS, Student Publications
"I'm old enough to be living in the future I was warned about."
  - Myron Krueger
=--

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBN5np1EwK0JxvsXXVEQKeYgCgjtm7Z1U7UVh/DkSV/4W8daWsfToAoJyt
xRtwBk2TmtwJ257GihUDfJQ4
=n609
-----END PGP SIGNATURE-----


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
