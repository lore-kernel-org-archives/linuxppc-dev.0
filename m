Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62D341A0014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 20:45:57 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 19:45:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B4D482CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 20:45:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP9jeXq37421066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 20:45:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP9jFPB031491
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 20:45:16 +1100
Message-ID: <56558310.50000@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 15:14:48 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 17/31] powerpc/booke: Move nohash headers (part 5)
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This and some previous patches can use some amount of description
in the commit message to make them clear. Now these first 17 patches
in the series are code movement and re organization of header files
into book3s (32/64) and book3e (32/64) buckets. Patches starting
from 18/31 till 31/31 changes the existing PTE format and related
stuff. So first 17 patches can be reviewed as a separate series
and considered before dealing with proposed PTE changes. In that
scheme of things patches 09/31 and 10/31 which prevents pte_val,
pmd_val, pud_val etc being used as lvalue should also be at the
end of the series after all movement of headers have been completed
not in the middle of it.
