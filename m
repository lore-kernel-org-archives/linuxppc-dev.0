Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPS2g6g3FzDrhx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:10:19 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: olof@lixom.net,
	chzigotzky@xenosoft.de
Date: Wed, 31 Aug 2016 13:24:27 +0100 (BST)
Message-ID: <48ba9b70551.5333d094@auth.smtp.1and1.co.uk>
Subject: [ RFC PATCH 0/3] powerpc/pasemi: initial Nemo motherboard support.
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series of 3 patches brings initial device tree patches for
A-Eon's Nemo motherboard, as used in the Amigaone X1000.

The dtb passed by the CFE firmware has a number of issues, which up till
now have been fixed by use of patches applied to the mainline kernel.
This occasionally causes problems with changes made to mainline.

Patching the firmware to correct the dtb is not an option for the 
following reasons:

It was modified by a 3rd party, and we don't have a copy of the source.

All versions of CFE used on the X1000 export the same dtb.

At least one machine suffered damage during a firmware upgrade attempt,
many people will be unwilling to reflash their system if an upgrade is
produced.

I've changed the config option 'CONFIG_PPC_PASEMI_SB600' used in our 
current patch 'CONFIG_PPC_PASEMI_NEMO' which I think better describes
its function.

Kind regards
Darren
