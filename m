Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr55t0sQHzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 14:16:02 +1000 (AEST)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qr55s31bDz9t3s
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Apr 2016 14:16:01 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id er2so24631149pad.3
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 21:16:01 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Always use STRICT_MM_TYPECHECKS
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571853FA.5080901@gmail.com>
Date: Thu, 21 Apr 2016 14:15:54 +1000
MIME-Version: 1.0
In-Reply-To: <1461209879-15044-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21/04/16 13:37, Michael Ellerman wrote:
> Testing done by Paul Mackerras has shown that with a modern compiler
> there is no negative effect on code generation from enabling
> STRICT_MM_TYPECHECKS.
> 
> So remove the option, and always use the strict type definitions.
> 

Should we wait for Aneesh's patches before merging this in. I like the reduction
in the definition of page level metadata so for that

Acked-by: Balbir Singh <bsingharora@gmail.com>
