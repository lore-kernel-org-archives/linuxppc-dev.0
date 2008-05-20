Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E8ACDECF2
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:36:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4KGZrfW018668
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:35:54 -0700 (MST)
Message-ID: <4832FDE8.50902@freescale.com>
Date: Tue, 20 May 2008 11:35:52 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>, Jon Loeliger <jdl@freescale.com>
Subject: Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.
References: <loom.20080519T223903-170@post.gmane.org>
	<20080519180337.234b11b4.kim.phillips@freescale.com>
In-Reply-To: <20080519180337.234b11b4.kim.phillips@freescale.com>
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

Kim Phillips wrote:
> On Mon, 19 May 2008 22:57:29 +0000 (UTC)
> Gary Hannon <ghannon@cspi.com> wrote:
> 
> 
>> Am I missing a flag on the dtc?
> 
> try adding -R 8 -S 0x3000 to the dtc command line.

Maybe we should be making this the default for dtc?  After all, it's needed for
any modern U-boot.

-- 
Timur Tabi
Linux kernel developer at Freescale
