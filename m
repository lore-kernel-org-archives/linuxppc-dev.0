Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48E631A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 16:13:03 +1000 (EST)
Message-ID: <1412057581.19209.2.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH 08/15] powerpc/mm: Add new hash_page_mm()
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 30 Sep 2014 16:13:01 +1000
In-Reply-To: <1412054407.1733.77.camel@ale.ozlabs.ibm.com>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-9-git-send-email-mikey@neuling.org>
 <87wq8mq07u.fsf@linux.vnet.ibm.com>
 <1412054407.1733.77.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, anton@samba.org,
 imunsie@au1.ibm.com, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > You also added code to handle KERNEL_REGION_ID in
> > [PATCH 02/15] powerpc/cell: Move data segment faulting code out of cell
> > platform. do we need to handle that here ?
> >=20

(Sorry missed this on my other reply...)

I've refactored that code now so it should be handled in the vsid
calculation.  It's not my strong area so you might wanna check on
repost.

Thanks again.

Mikey
