Date: Thu, 14 Feb 2002 16:01:35 -0600 (CST)
From: "Jared H. Hudson" <jhhudso@volumehost.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IBM NetStation 300 w/PowerPC 403GCX
Message-ID: <Pine.LNX.4.44.0202141550100.14550-100000@volumehost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm attempting to get linux running on a IBM NetStation 300.
A IBM NetStation 300 is a Network Terminal, with the following specs:

1-2MB of Video RAM, S3 Trio64V Video Chipset
16-64MB of System RAM (2 x 72pin slots)
66MHz PowerPC 403GCX Processor
PCMCIA interface (single slot)
PS2 keyboard port
PS2 mouse
10baseT Ethernet
9-pin serial port
parralel port
video port
8-bit sound w/onboard speaker

This has the same processor as the Tivo, I believe, so I would assume that
it would be possible to run Linux on it, assuming I can find a way to
bootload it.

The BIOS boots a kernel via TFTP, NFS, or local (presumedly PCMCIA flash)
The BIOS allows you to set the TFTP/NFS directory, kernel name, ip info,
screen resolution, ect.

When I start a TFTP server and place a misc file, or one of the 2.3.42
kernel images (w/bootloader I believe) from
http://gfs.lcse.umn.edu/~grant/Linux/ the BIOS says Incorrect file type,
versus File not found (which matching file isn't there)

Anyone here ever loaded linux on a IBM NetStation before?

Ideas?

-Jared H.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
