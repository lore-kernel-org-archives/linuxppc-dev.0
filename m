Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp10.blacknight.com (outbound-smtp10.blacknight.com
 [46.22.139.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3820E1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 19:43:59 +1100 (AEDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
 by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 0079F1C58A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 08:34:36 +0000 (GMT)
Date: Thu, 3 Mar 2016 08:34:35 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Li Zhang <zhlcindy@gmail.com>
Cc: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Li Zhang <zhlcindy@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 2/2] powerpc/mm: Enable page parallel initialisation
Message-ID: <20160303083435.GJ2854@techsingularity.net>
References: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
 <1456988501-29046-3-git-send-email-zhlcindy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1456988501-29046-3-git-send-email-zhlcindy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 03, 2016 at 03:01:41PM +0800, Li Zhang wrote:
> From: Li Zhang <zhlcindy@linux.vnet.ibm.com>
> 
> Parallel initialisation has been enabled for X86,
> boot time is improved greatly.
> On Power8, for small memory, it is improved greatly.
> Here is the result from my test on Power8 platform:
> 
> For 4GB memory: 57% is improved
> For 50GB memory: 22% is improve
> 
> Signed-off-by: Li Zhang <zhlcindy@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
