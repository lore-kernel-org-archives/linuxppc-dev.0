Return-Path: <SRS0+74e5df922a9970c849fe+454+infradead.org+hch@phoenix.srs.infradead.org>
Received: from phoenix.infradead.org (phoenix.infradead.org [81.187.226.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F3242BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Nov 2004 04:16:51 +1100 (EST)
Date: Sat, 20 Nov 2004 16:26:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20041120162622.GA19099@infradead.org>
References: <419E6900.5070001@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <419E6900.5070001@mvista.com>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Just looking through this and you should share some more code with mips,
e.g. the mavell register layout should move from asm-mips/marvell.h and
your file to linux/marvell.h or something, especially as another ppc
plattform (pegasosII) needs it aswell.  
