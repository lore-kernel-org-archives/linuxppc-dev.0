Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from embeddedplanet.com (unknown [66.94.95.194])
	by ozlabs.org (Postfix) with ESMTP id 5D78667A71
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 06:52:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 25 Feb 2005 14:40:11 -0500
Message-ID: <1628E43D99629C46988BE46087A3FBB91C4AA7@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: <tsawyer+linuxppc@sandburst.com>, "ppcembed" <linuxppc-embedded@ozlabs.org>
Subject: RE: 2.6 4xx GPIO OCP driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In 2.4 we used the drivers/char/ibm_ocp_gpio.c module.  I see=20
> no such support in 2.6.10.  I perused the archives, found=20
> nothing (OBTW: can someone point me to the search engine for=20
> the list?)

I see it.  Drivers/char/ibm_gpio.c in Linux 2.6.10-rc3.
