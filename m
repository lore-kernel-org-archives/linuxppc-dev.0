Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 1F99DDDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 21:23:54 +1000 (EST)
Date: Fri, 25 May 2007 13:24:14 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Geert.Uytterhoeven@sonycom.com
Subject: Re: [patch 6/7] ps3: ROM Storage Driver
Message-ID: <20070525112414.GA32336@aepfle.de>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.677742000@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070525083632.677742000@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, Geert.Uytterhoeven@sonycom.com wrote:

> +++ b/drivers/scsi/ps3rom.c

> +			kaddr = kmap_atomic(sgpnt->page, KM_USER0);

linux/highmem.h is not included to get the kmap_* prototypes.
