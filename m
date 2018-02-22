Return-Path: <srs0=6jub=fq=linux.vnet.ibm.com=fbarrat@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCyT67gkzDrRX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:16:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znCyS5Kvpz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:16:48 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znCyQ45Bzz9sW3
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 23:16:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MCAb8c095719
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 07:16:44 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9wjerfwb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 07:16:43 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 12:16:41 -0000
Subject: Re: [PATCH v3 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, frederic.barrat@fr.ibm.com, gregkh@linuxfoundation.org,
 andrew.donnellan@au1.ibm.com, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:16:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7793f52d-23f5-27bc-37c4-232e569bbaa1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/02/2018 à 05:17, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



>   Documentation/accelerators/ocxl.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 4f7af841d935..ddcc58d01cfb 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -152,6 +152,11 @@ OCXL_IOCTL_IRQ_SET_FD:
>     Associate an event fd to an AFU interrupt so that the user process
>     can be notified when the AFU sends an interrupt.
> 
> +OCXL_IOCTL_GET_METADATA:
> +
> +  Obtains configuration information from the card, such at the size of
> +  MMIO areas, the AFU version, and the PASID for the current context.
> +
> 
>   mmap
>   ----
> 
