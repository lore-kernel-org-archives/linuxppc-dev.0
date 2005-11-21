Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 577EA687B7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 02:57:48 +1100 (EST)
Date: Mon, 21 Nov 2005 08:57:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051121085745.A19935@cox.net>
References: <1132583169.11785.44.camel@mephisto.spb.rtsoft.ru>
	<4381E1A1.1060405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4381E1A1.1060405@ru.mvista.com>;
	from vbordug@ru.mvista.com on Mon, Nov 21, 2005 at 06:02:57PM
	+0300
Cc: "Ruslan V. Sushko" <rsushko@ru.mvista.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/3] ppc32: MTD support for Yucca board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 21, 2005 at 06:02:57PM +0300, Vitaly Bordug wrote:
> Guess this should come through MTD community (linux-mtd@lists.infradead.org), rebased to 
> the MTD tree of course.

Indeed, however, it need to be split so the driver/mtd portion goes to
the MTD maintainers. The arch/ppc portion will go in through the powerpc
tree.

-Matt
