Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBP570dHbzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:20:26 +1100 (AEDT)
Subject: Re: [PATCH v11 0/9] complete deferred page initialization
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <bd333387-fefc-c48a-2258-1d8c36f2db41@oracle.com>
Date: Tue, 10 Oct 2017 13:19:19 -0400
MIME-Version: 1.0
In-Reply-To: <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I wanted to thank you Michal for spending time and doing the in-depth 
reviews of every incremental change. Overall the series is in much 
better shape now because of your feedback.

Pavel

On 10/10/2017 10:15 AM, Michal Hocko wrote:
> Btw. thanks for your persistance and willingness to go over all the
> suggestions which might not have been consistent btween different
> versions. I believe this is a general improvement in the early
> initialization code. We do not rely on an implicit zeroing which just
> happens to work by a chance. The perfomance improvements are a bonus on
> top.
> 
> Thanks, good work!
> 
