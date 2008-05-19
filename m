Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00C6DDE0E1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:03:47 +1000 (EST)
Date: Mon, 19 May 2008 18:03:37 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Gary Hannon <ghannon@cspi.com>
Subject: Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.
Message-Id: <20080519180337.234b11b4.kim.phillips@freescale.com>
In-Reply-To: <loom.20080519T223903-170@post.gmane.org>
References: <loom.20080519T223903-170@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 May 2008 22:57:29 +0000 (UTC)
Gary Hannon <ghannon@cspi.com> wrote:


> Am I missing a flag on the dtc?

try adding -R 8 -S 0x3000 to the dtc command line.

Kim
