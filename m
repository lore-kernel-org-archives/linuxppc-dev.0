Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scxwn3yLCzDsdP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 17:15:05 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hi10so671776pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 00:15:05 -0700 (PDT)
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 santhosh <santhog4@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
 <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
 <1e406f4d-25bc-c92b-8a5e-5d59ae28a274@gmail.com>
 <87oa3nyivt.fsf@linux.vnet.ibm.com>
Cc: manvanth@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <1bbaa3d4-b6a2-542f-f00f-7315a0a9d13f@gmail.com>
Date: Mon, 19 Sep 2016 17:15:17 +1000
MIME-Version: 1.0
In-Reply-To: <87oa3nyivt.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/09/16 01:16, Aneesh Kumar K.V wrote:
> -	range 9 13 if PPC64 && !PPC_64K_PAGES
> +	range 13 13 if PPC64 && !PPC_64K_PAGES
>  	default "13" if PPC64 && !PPC_64K_PAGES

Do we still want t to be 13 13 or 12 13? 
Looks like the lower side of the range can cause issues based
on the values of Huge page size


Balbir Singh.
