Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQCNz5VrmzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 14:43:31 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u594YaLA056261
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 00:43:29 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m495nx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 00:43:29 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 9 Jun 2016 14:43:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C2D3C3578061
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 14:43:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u594grTi60620992
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 14:42:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u594gbin032201
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jun 2016 14:42:38 +1000
Date: Thu, 9 Jun 2016 14:42:25 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, ego@linux.vnet.ibm.com, mikey@neuling.org,
 maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 08/11] powerpc/powernv: Add platform support for stop
 instruction
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464871141-11568-9-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464871141-11568-9-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <20160609044225.GA16550@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2016 at 07:38:58AM -0500, Shreyas B. Prabhu wrote:

...

> +/* Power Management - PSSCR Fields */

It might be nice to give the full name of the register, as below with the FPSCR.

> +#define PSSCR_RL_MASK		0x0000000F
> +#define PSSCR_MTL_MASK		0x000000F0
> +#define PSSCR_TR_MASK		0x00000300
> +#define PSSCR_PSLL_MASK		0x000F0000
> +#define PSSCR_EC		0x00100000
> +#define PSSCR_ESL		0x00200000
> +#define PSSCR_SD		0x00400000
> +
> +
>  /* Floating Point Status and Control Register (FPSCR) Fields */

Cheers,
Sam.
