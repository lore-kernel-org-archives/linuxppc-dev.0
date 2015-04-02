Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53EF11A0729
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 13:16:24 +1100 (AEDT)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 22:16:21 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6D64E38C8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 22:16:19 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t322GJKZ30801926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 02:16:19 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t322GHC1031345
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 22:16:18 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/powernv: Add interfaces for flash device
 access
In-Reply-To: <1427868330.742068.357457598273.1.gpush@pablo>
References: <1427868330.742068.357457598273.1.gpush@pablo>
Date: Thu, 02 Apr 2015 13:16:14 +1100
Message-ID: <m31tk32s29.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cyril Bur <cyrilbur@gmail.com>, Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jeremy Kerr <jk@ozlabs.org> writes:

> From: Cyril Bur <cyrilbur@gmail.com>
>
> This change adds the OPAL interface definitions to allow Linux to read,
> write and erase from system flash devices. We register platform devices
> for the flash devices exported by firmware.
>
> We clash with the existing opal_flash_init function, which is really for
> the FSP flash update functionality, so we rename that initcall to
> opal_flash_update_init().
>
> A future change will add an mtd driver that uses this interface.
>
> Changes from Joel Stanley and Jeremy Kerr.
>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acking that firmware calls are merged into skiboot.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
