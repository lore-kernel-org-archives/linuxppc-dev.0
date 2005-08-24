Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id A939668046
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 22:43:10 +1000 (EST)
Message-ID: <430C6410.90805@sandburst.com>
Date: Wed, 24 Aug 2005 08:12:00 -0400
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: RPXClassic Help
Reply-To: tsawyer+linuxppc@sandburst.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings:

I got my hands on a couple of RPXClassic (CLLF) boards gratis
and am planning on putting them to some use with my model
railroad (overkill, but its fun!).

I have them running Das U-Boot git as of ~ 16August2005.

I'm attempting to use a kernel.org 2.4.30 kernel. (With
i2c-2.9.0 patches)

After pushing the bd_t struct into rpxclassic.h, the board
boots linux well, mounts the nfs root properly, things are
good.

I would like to get a pcmcia flash disk working.  It is id'ed
by Das U-Boot:

PCMCIA:SunDisk SDP 5/3 0.6
             Fixed Disk Card
             IDE interface
             [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Bus 0: OK
   Device 0: Model: SanDisk SDP3B-64 Firm: vdd 1.00 Ser#: g3vspq15924
             Type: Removable Hard Disk
             Capacity: 61.2 MB = 0.0 GB (125440 x 512)

After enabling pcmcia, 8xx pccard, ide, et al (and some debug printk's)
I get the following output from the kernel:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
PCMCIA slot B: phys mem e0000000...e8010000 (size 08010000)
Card ID: SunDisk SDP 5/3 0.6
  Fixed Disk Card
  IDE interface
  [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Probing IDE interface ide0...
probing for hda: present=0, media=32, probetype=ATA
do_probe 471
probing for hda: present=0, media=32, probetype=ATAPI
do_probe 471
probing for hdb: present=0, media=32, probetype=ATA
do_probe 471
probing for hdb: present=0, media=32, probetype=ATAPI
do_probe 471
Linux Kernel Card Services 3.1.22
   options:  none
m8xx_pcmcia: Version 0.05, 14-Apr-2002
m8xx_pcmcia: RPX CLASSIC or RPX LITE using SLOT_B with IRQ 13.


Nothing shows up in /proc/ide other than 'drivers'
bash-2.05b# cat drivers
ide-disk version 1.17
ide-default version 0.9.newide


I tried googling to no avail.  Any ideas?

TIA,

Travis
