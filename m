Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18B1B679F6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2006 23:15:57 +1000 (EST)
Date: Tue, 9 May 2006 15:15:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509131547.GA8449@lst.de>
References: <4450A196.2050901@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4450A196.2050901@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#include <linux/interrupt.h>
> +#include <asm/atomic.h>
> +#include <asm/types.h>

Please don't use <asm/types.h> directly ever.  Always include
<linux/types.h>
