Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FD471A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 01:12:19 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 20:42:16 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6437A125801A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 20:41:49 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UEq0r956426534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 20:42:12 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UD9gUo026564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 18:39:43 +0530
Message-ID: <560BDF15.1070302@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 18:39:41 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 26/31] powerpc/mm: Remove the dependency on pte bit
 position in asm code
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1443580044-30659-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2015 07:57 AM, Aneesh Kumar K.V wrote:
> We should not expect pte bit position in asm code. Simply
> by moving part of that to C

I guess this does not depend on the new code changes and can
simply be part of the preparatory patches at the beginning. 
