Date: Wed, 9 Aug 2000 02:39:34 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: IDE on MBX/821 working
Message-ID: <Pine.LNX.4.21.0008090209110.20744-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A while back I mentioned that I was trying to get an IDE drive
working on an MBX/821 board.  This was rumored to have worked
before by various people in this thread,

 http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00054.html

Anyway, I did eventually get it to work, including partitioning, ext2
formatting, mounting, read/write, with PCMCIA CompactFlash at the same
time, using the 2.2.13 kernel from Monta Vista CDK 1.0, and Magnus
Damm's m8xx PCMCIA driver.

I put together a few web pages with some notes and a set of patches
against the 2.2.13 Monta Vista kernel source, at

  http://www.bluebutton.com/proj/mbxlinux/

for anyone who wants to try getting this working on the same or similar
system.

-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
