Date: 12 Oct 2001 06:33:03 -0000
Message-ID: <20011012063303.8041.qmail@mailFA8.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to download zImage into sandpoint RAM
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
 Gotta lot of qns..:(

I managed to download HHL-journeyman mvista,
compiled the kernel and got a "zImage.sandpoint"
Now, I got "DINK" runnin in the sandpoint board,
to which i am connected via serial port.

 How shoudl i download this image into the RAM and
whats the ctrl flow..How does the kernel get loaded.
>From the kernel source, i assume that the kernel is
loaded at location 0x000 by any PPC bios
 (arch/ppc/kernel/head.S is written assuming this..
  Am i right ? Or some how the entire kernel is copied
  to 0x00 after getting loaded. so that exception
   handlers are in place ). In that case, wont this
  destroy the DINK RAM image..So, once I download the
 kernel and jump to it i cant use DINK, right ? sounds
 logical )

 The  first address where I cand ownload this image is
 0x90000, right ? first free user address after DINK.

 I know about "dl" command in DINK.. How do i write
the "zImage" to the "COM" port.. just "cat zImage > /dev/ttyS0" would do ? or Should i strip the first
64k of zImage ? In that case, can any1 tell me why
I should do that ? Do i need "ppcboot" to download and
run this kernel. I dont have any harddisk on the target.
 So, Whats the root file system I should mention ?

 I have another problem, I m running in windows and
 connecting via HyperTerminal. I m not able
 to connect from linux using minicom or anythin..
 I get only junk characters on the screen :( Baud
 rate is correct.


Thanx

Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
