Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id E2A2F2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 02:37:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jan 2005 10:37:27 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB912F245@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Hans Schillstrom" <hans.schillstrom@pwav.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: mpc8270vr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> Hi,
> Is there any one that have a mpc8270vr (rev 0.01 1k49M mask)=20
> running a 2.6 kernel ?

I have 2.6.10-rc3 booting just fine on a 8270 and 8280 as well as 8250
and 8260.

> I have a couple of boards with mpc8250vr and mpc8270vr (the=20
> board is identical for the processor).
> The kernel image is the same, the 8250 works fine.
> The 8270 hangs when creating the init thread:
>   kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);

Don't know why it would die there but the calcualtions for the clocks on
an 8250 are different than that of the 8270.  If it is working on the
8250 then you may be doing the calculations wrong on the 8270.  Other
than the clocks it should be the same.
