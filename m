Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id F0D782BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 07:49:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 23 Dec 2004 15:49:30 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB912EB11@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: 2.6.10-rc3 for 8xx booting "load_kernel(...)" function problem
	vs configuring and initializing serial console ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> CONFIG_CMDLINE=3D"console=3DttyCPM0 panic=3D3 root=3D/dev/ram"

All I had to do to get the rpxlite running was do "console=3DttyCPM0
root=3D/dev/ram rw".  Check the default config for the rpxlite, that may
help you.

>  ********(then from load_kernel() I would see)**********=20
>  loaded at:     00180000 0035622C
>  board data at: 0035313C 0035317C
>  relocated to:  001852CC 0018530C
>  zimage at:     001857F9 00226057
>  initrd at:     00227000 00352ADF
>  avail ram:     00357000 02000000
> =20
>  Linux/PPC load: panic=3D3 root=3D/dev/ram
>  Uncompressing Linux...done.

It would appear you did not recompile the kernel or you did not reload
it.  It still shows the command line without console=3DttyCPM0.
