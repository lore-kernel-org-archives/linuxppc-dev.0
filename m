Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D1B7679E0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:34:24 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBCNYMh4015731
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 18:34:22 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBCNYLoR099460
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:34:21 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBCNYLXF029357
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:34:21 -0700
Date: Tue, 12 Dec 2006 17:34:21 -0600
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH] drivers/ata: PATA driver for Celleb
Message-ID: <20061212233421.GM4329@austin.ibm.com>
References: <200612120206.kBC26wHr022838@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200612120206.kBC26wHr022838@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linux-ide@vger.kernel.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2006 at 11:08:24AM +0900, Akira Iguchi wrote:
> 
> I use some static functions in libata-core.c because it makes

You will want to split this patch into several pars, and submit the 
changes to libata-core.c separately.

> --- linux-2.6.19/drivers/ata/libata-core.c	Wed Dec  6 12:00:47 2006
> ***************
> *** 600,606 ****
>    *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
>    */
>   
> ! static unsigned int
>   ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
>   {
>   	struct ata_taskfile tf;
> --- 600,606 ----
>    *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
>    */
>   
> ! unsigned int
>   ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)

Please generate unified diffs (diff -pu) or use quilt,
this makes the patches easier to read. (and smaller)

--linas
