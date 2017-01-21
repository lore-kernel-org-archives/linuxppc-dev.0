Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v5RFL6kHfzDqV0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 05:39:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0LIcfAP137296
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 13:39:32 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2844ktp71s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2017 13:39:31 -0500
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sat, 21 Jan 2017 18:39:29 -0000
Subject: Re: [PATCH] cxl: drop unused header asm/pnv-pci.h
To: Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org
References: <148482301037.30441.14177888563610790803.stgit@bahia>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Sat, 21 Jan 2017 12:39:24 -0600
MIME-Version: 1.0
In-Reply-To: <148482301037.30441.14177888563610790803.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <aee23cd5-f663-3437-dd98-11ea19561cc7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/01/2017 à 04:50, Greg Kurz a écrit :
> The kernel API does not use anything from this header file.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
