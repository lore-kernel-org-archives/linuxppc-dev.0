Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWQhB4pVfzDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:30:50 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4M4TbKs004439
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 00:30:42 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2akk899ku3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 00:30:42 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 22 May 2017 14:30:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4M4USVO2949410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:30:36 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4M4Tv3F003254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 14:29:57 +1000
Subject: Re: [PATCH 1/2] powerpc: Don't fortify prom_init
To: Daniel Axtens <dja@axtens.net>, kernel-hardening@lists.openwall.com,
 linuxppc-dev@lists.ozlabs.org
References: <20170522013233.21780-1-dja@axtens.net>
 <20170522013607.89E5CAE034@b01ledav005.gho.pok.ibm.com>
Cc: Daniel Micay <danielmicay@gmail.com>, Kees Cook <keescook@chromium.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 22 May 2017 14:29:39 +1000
MIME-Version: 1.0
In-Reply-To: <20170522013607.89E5CAE034@b01ledav005.gho.pok.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <df86cc49-03e6-be24-0b5e-fd0d0d618f48@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/05/17 11:32, Daniel Axtens wrote:
> prom_init is a bit special; in theory it should be able to be
> linked separately to the kernel. To keep this from getting too
> complex, the symbols that prom_init.c uses are checked.
>
> Fortification adds symbols, and it gets quite messy as it includes
> things like panic(). So just don't fortify prom_init.c for now.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
