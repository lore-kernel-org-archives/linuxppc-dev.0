Message-ID: <38F24018.16C3266F@charter.net>
Date: Mon, 10 Apr 2000 15:56:56 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: How to get zImage into rom for 8xxrom on FADS board.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Please, no snide remarks about the FADS.  :)

I now have 8xxrom compiled, loaded, and running on my FADS.
But, of course - no disks, nor file system in flash.
Can someone detail how I can take a zImage and get it
into flash so that 8xxrom will boot it?  I've just about
managed it (8xxrom will detect ELF images and load them),
but not quite yet.  I'm using mpc8bug to download Srecords
to the flash - so in short, I'm asking how to create an
S-record file of either a small fs (with the zImage file in
it), or create the S-record file of the zImage suitable
for downloading.  Surely, someone has done this before...
what's the magic incantation?
I'll eventually figure it out, but I was hoping someone
out there could help speed up the process by telling me
the secret.  :)
Thanks!
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
