Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFA85680A7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 23:19:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 24 Aug 2005 08:49:40 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB931EBD6@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: <tsawyer+linuxppc@sandburst.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: RPXClassic Help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
>ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=3Dxx PCMCIA slot B: phys mem >           >e0000000...e8010000 =
(size
08010000) Card ID: SunDisk SDP 5/3 0.6
>  Fixed Disk Card
>  IDE interface
>  [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Probing IDE interface ide0...
>probing for hda: present=3D0, media=3D32, probetype=3DATA do_probe 471
probing for hda: present=3D0, media=3D32,          >probetype=3DATAPI =
do_probe
471 probing for hdb: present=3D0, media=3D32, probetype=3DATA do_probe =
471
probing for hdb:  >present=3D0, media=3D32, probetype=3DATAPI do_probe =
471
Linux Kernel Card Services 3.1.22
>   options:  none
>m8xx_pcmcia: Version 0.05, 14-Apr-2002
>m8xx_pcmcia: RPX CLASSIC or RPX LITE using SLOT_B with IRQ 13.

I use the PCMCIA card services at sourceforge instead of the built in
support.  They work very well including ATA/IDE.
