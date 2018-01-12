Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHz9y66XtzF0Zq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 21:14:14 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0CADxEg093316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:14:12 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fepuma8m0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:14:11 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 12 Jan 2018 10:14:10 -0000
Subject: Re: [PATCH v6 2/2] cxl: read PHB indications from the device tree
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com
References: <20180111150103.3137-1-felix@linux.vnet.ibm.com>
 <20180111150103.3137-2-felix@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 11:14:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180111150103.3137-2-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c14eaf00-da24-1c6e-1403-f8670082d1be@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 11/01/2018 à 16:01, Philippe Bergheaud a écrit :
> Configure the P9 XSL_DSNCTL register with PHB indications found
> in the device tree, or else use legacy hard-coded values.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: New patch. Use the new device tree property "ibm,phb-indications".
> 
> v3: No change.
> 
> v4: No functional change.
>      Drop cosmetic fix in comment.
> 
> v5: get_phb_indications():
>        - make static variables local to function.
>        - return static variable values by arguments.
> 
> v6: get_phb_indications():
>        - acquire a mutex before setting the phb indications.
> 
> This patch depends on the following skiboot patch:
>    https://patchwork.ozlabs.org/patch/858324/
> ---
>   drivers/misc/cxl/cxl.h    |  2 +-
>   drivers/misc/cxl/cxllib.c |  2 +-
>   drivers/misc/cxl/pci.c    | 50 ++++++++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 47 insertions(+), 7 deletions(-)
> 

Acked-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
