Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmQDb3XQtzF0mM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 15:56:15 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1L4sog8134443
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 23:56:13 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g8ww6q9my-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 23:56:12 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 23:56:11 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>, benh@au1.ibm.com,
 clombard@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: [PATCH v9 1/2] powerpc/powernv: Enable tunneled operations
In-Reply-To: <20180220155111.20459-1-felix@linux.vnet.ibm.com>
References: <20180220155111.20459-1-felix@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 15:56:06 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87sh9vuejd.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 94bd1bf2c873..07b5e2240ecc 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -204,7 +204,9 @@
>  #define OPAL_NPU_SPA_SETUP			159
>  #define OPAL_NPU_SPA_CLEAR_CACHE		160
>  #define OPAL_NPU_TL_SET				161
> -#define OPAL_LAST				161
> +#define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		162
> +#define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		163
> +#define OPAL_LAST				163


These numbers will change as other calls have gone in with those OPAL
API ids.

Feel free to send a tiny patch to skiboot reserving some though.

I should probably encourage people to do that when they start working on
new API calls.

-- 
Stewart Smith
OPAL Architect, IBM.
