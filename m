Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq7My32d1zDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:55:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D5reHq064239
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:55:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452yp6gjr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:55:08 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Jul 2016 15:55:05 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 942C22CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:55:01 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D5t15U14417958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:55:01 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D5t0kq015095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:55:01 +1000
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 Jul 2016 15:54:59 +1000
In-Reply-To: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1468389299.4705.26.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-13 at 15:47 +1000, alastair@au1.ibm.com wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> > This series allows the vmx_crypto module to be detected and
> automatically
> loaded via UDEV if the CPU supports the vector crypto feature.
> > Alastair D'Silva (2):
>   powerpc: Add module autoloading based on CPU features
>   crypto: vmx - Convert to CPU feature based module autoloading
> >  arch/powerpc/Kconfig                  |  1 +
>  arch/powerpc/include/asm/cpufeature.h | 70
> +++++++++++++++++++++++++++++++++++
>  drivers/crypto/vmx/Kconfig            |  2 +-
>  drivers/crypto/vmx/vmx.c              |  6 +--
>  4 files changed, 74 insertions(+), 5 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/cpufeature.h

Please ignore the following:
  [PATCH 1/2] Allow drivers to be autoloaded.
  [PATCH 2/2] Automatically load the vmx_crypto module if supported.

-- Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
