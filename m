Message-ID: <38F5C457.C46F04B2@execpc.com>
Date: Thu, 13 Apr 2000 07:57:59 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
References: <200004130939.LAA10861@denx.local.net> <38F5B1C0.FC8863EB@drea.dnd.ca>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gavin Hemphill wrote:
> Hmmm, I've been trying to replicate the problems with my two Wallstreet
...
> corruption abounds - Looks like it has something to do with an
> interatction on DMA with the internal IDE drive and the ethernet.

Could this be related to the IDE issues that have been discovered with my hard
drive?  This would mean that there could be a bug in the way DMA is implemented
in hardware on the wallstreet motherboard.  It has been mentioned its possible.
(small flashback: corruption on occation when playing sound, often ro programs
when executed (vi got hit; would run, but would error. few flipped bits
probably), mentioned in SoundJam's readme.  'Contact Apple')

Since MacOS doesn't seem to have any of these problems, there is a solution.

my hard drive from dmesg:
hda: IBM-DYLA-28100, ATA DISK drive
hda: IBM-DYLA-28100, 7815MB w/459kB Cache, CHS=15880/16/63, (U)DMA

Since my brother's lombard has a Toshiba HD, could this all be funkyness with
IBM drives, God forbid? (as opposed to just the BMAC+ doesnt have the hw bug)

Before we start being suspicious, anyone with a non-IBM drive having this
problem?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Did you ever notice how the Chinese Abacus, with 2 '5' beads and 5 '1'
beads, is perfect for hexidecimal math?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
