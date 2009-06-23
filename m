Return-Path: <alexs@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 99F54B7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 18:11:55 +1000 (EST)
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB15BDDD1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 18:11:53 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n5N8BRDt241864
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 08:11:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n5N8BRQG1237068
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 09:11:27 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n5N8BQ7q012368
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 09:11:26 +0100
Date: Tue, 23 Jun 2009 10:11:23 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ewg] Re: [PATCH 2.6.31 try 2] ehca: Tolerate dynamic memory
	operations and huge pages
Message-ID: <20090623101123.72690731@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <adabpofr0h2.fsf@cisco.com>
References: <200906091559.24661.hannes.hering@linux.vnet.ibm.com>
	<20090616091021.2acf7302@BL3D1974.boeblingen.de.ibm.com>
	<adabpofr0h2.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, ewg@lists.openfabrics.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 22 Jun 2009 22:19:21 -0700
Roland Dreier <rdreier@cisco.com> wrote:

> thanks, applied.
> 
>  > -#define HCAD_VERSION "0026"
>  > +#define HCAD_VERSION "0027"
> 
> the driver version was already 0027 (since bde2cfaf), so I dropped this chunk.

thank you for applying, we would like to increase the version number for this
patch, so please also apply the following:

ehca: Increment version number for DMEM toleration

Signed-off-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- infiniband.git.orig/drivers/infiniband/hw/ehca/ehca_main.c
+++ infiniband.git/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@
 #include "ehca_tools.h"
 #include "hcp_if.h"
 
-#define HCAD_VERSION "0027"
+#define HCAD_VERSION "0028"
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
