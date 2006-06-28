Return-Path: <SRS0+c81ddf811d472c051b1d+1039+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E75967B8A
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 03:10:04 +1000 (EST)
Date: Wed, 28 Jun 2006 18:09:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: [PATCH 3/7] powerpc: Add QE library qe_lib--common files
Message-ID: <20060628170949.GB7162@infradead.org>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD4@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD4@zch01exm40.ap.freescale.net>
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Gridish Shlomi-RM96313 <gridish@freescale.com>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All these config options to descibe hardware variants are not acceptable.
Please describe the hardware layout in the device tree.
