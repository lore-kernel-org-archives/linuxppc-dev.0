Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28C7AB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 15:39:40 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 17 May 2012 05:27:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4H5MolL48169078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 15:22:51 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4H5U1x8010795
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2012 15:30:01 +1000
Message-ID: <4FB48CD8.30709@linux.vnet.ibm.com>
Date: Thu, 17 May 2012 11:00:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fixing a cputhread code documentation
References: <4FB12570.9090503@linux.vnet.ibm.com>
In-Reply-To: <4FB12570.9090503@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Ben,

Because its too minor a documentation fix, did not write any description.
Not sure how it works, I thought this would be clubbed with other incoming
documentation fix in the same area. 

On Monday 14 May 2012 09:02 PM, Anshuman Khandual wrote:

> diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
> index ce516e5..ac3eedb 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -9,7 +9,7 @@
>   * Note: This implementation is limited to a power of 2 number of
>   * threads per core and the same number for each core in the system
>   * (though it would work if some processors had less threads as long
> - * as the CPU numbers are still allocated, just not brought offline).
> + * as the CPU numbers are still allocated, just not brought online).
>   *
>   * However, the API allows for a different implementation in the future
>   * if needed, as long as you only use the functions and not the variables
> 
> --
> Anshuman Khandual
