Date: Fri, 17 Nov 2000 15:32:43 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embeded@lists.linuxppc.org
Subject: HHL: RMON, SIMM programmer, and flash booting
Message-ID: <Pine.GSO.4.21.0011171516520.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I must be blind as I can't find the RMON program for the EST-8260 on
the mvista ftp site as they describe here in the lsp README:

The RMON program, srecord loader and SIMM programmer are available on
  the MontaVista FTP site and are included on the CDK CD.

I found the srecord loader, but I don't know where to find the SIMM
programmer either.  Can someone give me a hint?  When I find RMON, I
think I can burn it with my VisionICE-II.

Second question.  Does HHL supply any instructions or code to boot
directly from flash, or do I have to figure it out myself from the mailing
list archives and the HOWTO?  What I am looking for is the initial
code to set things up before calling zImage.  Does anyone have any
pointers or code to share for this?  I mean without DHCP and an NFS root
file system.  I know about the initial RAM disk, which brings me to my
last question (for now).

I also can't find the example initial RAM disk mentioned in the HOWTO
here:

Example
An example ramdisk.image.gz is already included in the Hard Hat kit.

Or is this figurative?  Meaning I have to make one on the target from the
NFS mounted file system?

Thanks for your help.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
