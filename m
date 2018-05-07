Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40frQ72S47zF1mb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 04:15:27 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w47I9IdN143573
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 14:15:25 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htqp2ku6e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 14:15:24 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 7 May 2018 19:15:22 +0100
Subject: Re: [PATCH v2 7/7] ocxl: Document new OCXL IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 20:15:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6c363687-531a-db76-2e94-382205dd89f0@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


>   Documentation/accelerators/ocxl.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 7904adcc07fd..3b8d3b99795c 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
> 
> +OCXL_IOCTL_ENABLE_P9_WAIT:
> +
> +  Allows the AFU to wake a userspace thread executing 'wait'. Returns
> +  information to userspace to allow it to configure the AFU. Note that
> +  this is only available on Power 9.
> +
> +OCXL_IOCTL_GET_FEATURES:
> +
> +  Reports on which CPU features that affect OpenCAPI are usable from
> +  userspace.
> +
>   mmap
>   ----
> 
