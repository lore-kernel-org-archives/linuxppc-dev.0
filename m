Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id C827A67A2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 04:00:19 +1100 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 16 Mar 2005 11:34:59 -0500
Date: Wed, 16 Mar 2005 11:33:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: looking for a model for building CRAMFS(?)-based system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


  i'm hoping someone has an example of the following that they're
willing to share.

  currently, the system i've built for our 850 board incorporates

	- boot loader (sadly, not u-boot, but i'm working on it)
	- standard zImage.initrd.bin kernel+initrd image
	... mountable JFFS2 filesystem with persistent stuff ...

  obviously, with this layout, it's kind of a nuisance to update
anything individually in the initrd portion of the system, so i'd like
to at least experiment with a layout that has separate

	- boot loader (ideally, u-boot)
	- kernel image
	- updateable (normally mounted read-only?) root filesystem
	... rest of stuff the same ...

  i'm going to start over at DENX with their docs since that seems to
be the canonical place to get the scoop on this but, in the meantime,
if anyone has built something like this and is willing to share, say,
their makefile so i can see how it goes together, i'd be thrilled.

  if your example happens to *require* u-boot, well, perhaps so much
the better since that will give me the incentive to switch. :-)

  thanks.

rday
