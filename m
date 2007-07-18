Return-Path: <jengelh@computergmbh.de>
Received: from sovereign.computergmbh.de (sovereign.computergmbh.de
	[85.214.69.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 168DDDDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 00:57:18 +1000 (EST)
Date: Wed, 18 Jul 2007 16:32:46 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
In-Reply-To: <20070716162206.392129000@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0707181632200.5385@fbirervta.pbzchgretzou.qr>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 16 2007 18:15, Geert Uytterhoeven wrote:
>
>Add a Disk Storage Driver for the PS3:
>  - Implemented as a block device driver with a dynamic major
>  - Disk names (and partitions) are of the format ps3d%c(%u)
>  - Uses software scatter-gather with a 64 KiB bounce buffer as the hypervisor
>    doesn't support scatter-gather

I wonder what virtualization has to do with a block device driver?


	Jan
-- 
