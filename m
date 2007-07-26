Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id E52C3DDF10
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:59:47 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so611262ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 12:59:46 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
Date: Thu, 26 Jul 2007 21:28:18 +0200
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725184312.44ca7a8c@the-village.bc.nu>
In-Reply-To: <20070725184312.44ca7a8c@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707262128.18720.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 July 2007, Alan Cox wrote:
> > pata_platform and ide_platform are carrying same driver names,
> > to easily switch between these drivers, without need to touch
> > platform code.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> Acked-by: Alan Cox <alan@redhat.com>

added
