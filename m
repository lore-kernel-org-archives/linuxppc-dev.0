Message-Id: <199901161111.GAA00502@smtp-gw.vma.verio.net>
Date: Sat, 16 Jan 1999 06:11:03 -0500 (EST)
From: baccala@freesoft.org
Subject: RS/6000 860 portable - who wrote the display code?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi -

I've got an IBM RS/6000 860 portable running Linux/ppc.  I've having
strange problems with the display - characters that show up in the
wrong places; garbled scanlines; it's rather hard to describe in words.
I've checked the video memory with KGDB - it's contents are correct.

I'm becoming more and more convinced that my display problems are
either in hardware or in the VGA controller programming.  I've found
that the problem exists in the boot loader as well as the Linux kernel
proper.  Even more suspicious is a section of code in
arch/ppc/boot/vreset.c that's just for my Aurora64V+ display
controller chip (the section labeled "IBM Portable 860" - but it's keyed
off the chip's ID code).  I've determined that the code does run during
my boot cycle, and that commenting it out gives me a blank screen.

I've got the databook on the chip, but right now I feel like I'm just
flailing at something I don't understand.  Does anyone know who wrote the
Aurora64V+ code in vreset.c?  Does anyone else on this list have an 860
laptop?  Any help is appreciated.
-- 
					-bwb

					Brent Baccala
					baccala@freesoft.org

-------------------------------------------------------------------------
To receive periodic news about what's happening at freesoft.org, send
email to "announce@freesoft.org", with "SUBSCRIBE" as the message, i.e:
		echo SUBSCRIBE | mail announce@freesoft.org
-------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
