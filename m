Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD61C1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 20:12:55 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 14:42:52 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0P9Cjlr15532430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 14:42:46 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0P9CiQA014349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 14:42:45 +0530
Message-ID: <56A5E709.2070908@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 14:42:41 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  powerpc/perf: Remove PPMU_HAS_SSLOT flag for Power8
References: <1453710826-3160-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1453710826-3160-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2016 02:03 PM, Madhavan Srinivasan wrote:
>  Commit: 7a7868326d77 introduced PPMU_HAS_SSLOT flag to
>  remove assumption of MMCRA[SLOT] with respect to
>  PPMU_ALT_SIPR flag. Commit 7a7868326d77's message also
>  specifies that Power8 does not support MMCRA[SLOT].
>  But still PPMU_HAS_SSLOT flag managed to get into
>  Power8 code. Patch to remove the same from Power8 flags.

Please follow the present protocol of referring to a commit
ID like this (<hash_code>: ""). Also this PMU flag was added
originally through the base POWER8 PMU enablement commit
(e05b9b9e5c1: "powerpc/perf: Power8 PMU support") which can
be mentioned in the "Fixes:" part.
