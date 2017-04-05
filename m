Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyWcV6VJyzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 13:32:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v353TCdN044354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 23:32:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ktf88mfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 23:32:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 21:32:18 -0600
Date: Tue, 04 Apr 2017 20:32:05 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: herbert@gondor.apana.org.au, ddstreet@ieee.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com,
 hbabu@us.ibm.com
Subject: Re: [PATCH 1/5] crypto/nx: Rename nx842_powernv_function as icswx
 function
References: <1491065941.29552.26.camel@hbabu-laptop>
 <87inmkv348.fsf@concordia.ellerman.id.au>
In-Reply-To: <87inmkv348.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <58E46535.5080108@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2017 04:11 AM, Michael Ellerman wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> writes:
> 
>> [PATCH 1/5] crypto/nx: Rename nx842_powernv_function as icswx function
>>
>> nx842_powernv_function is points to nx842_icswx_function and
>> will be point to VAS function which will be added later for
>> P9 NX support.
> 
> I know it's nit-picking but can you give it a better name while you're
> there.
> 
> I was thinking it should be called "send" or something, but it actually
> synchronously sends and waits for a request.
> 
> So perhaps just nx842_exec(), for "execute a request", and then you can
> have nx842_exec_icswx() and nx842_exec_vas().
> 
> cheers
> 

Michael, 

Thanks for review,

nx842_powernv_function() was used before, So just renamed similar to this name. But I will make changes in the next version.

Haren 
