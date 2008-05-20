Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AB45DE0CB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:43:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4KGhqKP026294
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:43:53 -0700 (MST)
Message-ID: <4832FFC6.6060301@freescale.com>
Date: Tue, 20 May 2008 11:43:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.
References: <loom.20080519T223903-170@post.gmane.org>	<20080519180337.234b11b4.kim.phillips@freescale.com>
	<4832FDE8.50902@freescale.com> <4832FF80.5080408@freescale.com>
In-Reply-To: <4832FF80.5080408@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> How about fixing u-boot's deficiencies in u-boot?  It knows better than 
> dtc how much extra space it's going to need.

Then what's the point of the -R and -S options if U-boot doesn't really need them?

This sounds like another example of a bug in U-Boot that everyone knows about
but no one is fixing.

-- 
Timur Tabi
Linux kernel developer at Freescale
