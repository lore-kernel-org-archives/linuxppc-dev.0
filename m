Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5BC367BD6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 04:30:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ELDK 4.0 / GDB with mpc85xx
Date: Wed, 18 Oct 2006 14:00:40 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB972A26A@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Clint Thomas" <cthomas@Soneticom.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=A0
>My real question however is, will this effect the use of the crossGDB =
>provided with the ELDK? I want to use it with a BDI2000, and the =
>documentation on the Denx website shows it working, but I have also =
read >about issues related to the version of GDB, the BDI firmware, and =
the e500 >c.ore not playing nicely together. Has anybody had good =
experience getting >this setup fully functional? I really need to be =
able to step through the >U-boot code and see where it is failing on our =
platform. Thanks for the >help!
=A0

When the GDB defaults to powerpc:e500 problems do occur.  All you need =
to do is set it to powerpc:common and all works swell.  I've used it =
plenty of times.

(gdb) show architecture
The target architecture is set automatically (currently
powerpc:e500)
(gdb) set architecture powerpc:common
