Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 8401EDDEEE
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 08:01:47 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so887044ugf
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 14:01:45 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 1/2] scc_pata: dependency fix
Date: Sat, 17 Mar 2007 21:50:10 +0100
References: <200703160203.l2G23QgI022196@toshiba.co.jp>
In-Reply-To: <200703160203.l2G23QgI022196@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200703172150.11143.bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Friday 16 March 2007, Akira Iguchi wrote:
> This patch fixes:
> * the dependency of scc_pata on BLK_DEV_IDEDMA_PCI
> * incorrect link to ide-core
> * move scc_pata from ide/ppc to ide/pci
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

I applied both patches after:

* manually fixing the reject in drivers/ide/Kconfig
  (because Al's "IDE=y" fix has already been applied)

* merging patch #1 and #2 into a single one
  (otherwise patch #1 alone breaks kernel build)

Thanks,
Bart
