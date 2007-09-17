Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 44206DDDFE
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 21:06:58 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so806579uge
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 04:06:57 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] Remove unused variabls from
	drivers/ide/ppc/pmac.c
Date: Mon, 17 Sep 2007 12:16:07 +0200
References: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
In-Reply-To: <20070917140644.f62abe1e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709171216.08058.bzolnier@gmail.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 17 September 2007, Stephen Rothwell wrote:
> Removes these warnings:
> 
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_check':
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1807: warning: unused variable 'map'
> /home/sfr/kernels/linus/drivers/ide/ppc/pmac.c:1805: warning: unused variable 'pmif'
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

applied
