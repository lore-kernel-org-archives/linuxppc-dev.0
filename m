Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 187DD1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:51:51 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 19:51:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6B0462BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:51:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H9peKI25821186
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:51:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H9pEOM031533
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:51:15 +1100
Message-ID: <5507F8FA.7040004@linux.vnet.ibm.com>
Date: Tue, 17 Mar 2015 15:20:50 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/5] powerpc/vphn: parsing code rewrite
References: <20150223151412.21565.2251.stgit@bahia.local>
 <20150223151437.21565.8231.stgit@bahia.local>
In-Reply-To: <20150223151437.21565.8231.stgit@bahia.local>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/mm/vphn.h b/arch/powerpc/mm/vphn.h
> index 96af9a4..fe8b780 100644
> --- a/arch/powerpc/mm/vphn.h
> +++ b/arch/powerpc/mm/vphn.h
> @@ -6,10 +6,10 @@
>  #define VPHN_REGISTER_COUNT 6
>  
>  /*
> - * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
> - * the complete property we have to add the length in the first cell.
> + * 6 64-bit registers unpacked into up to 24 be32 associativity values. To

I guess its be16 instead of be32 here		^^^^
