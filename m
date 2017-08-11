Return-Path: <mgorman@techsingularity.net>
Received: from outbound-smtp04.blacknight.com (outbound-smtp04.blacknight.com
 [81.17.249.35])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTL721CK5zDr1s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 19:58:38 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
 by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id DF832992A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:50:09 +0000 (UTC)
Date: Fri, 11 Aug 2017 10:50:09 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Michal Hocko <mhocko@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-ID: <20170811095009.hz2vnatcwztffraw@techsingularity.net>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20170811093249.GE30811@dhcp22.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2017 at 11:32:49AM +0200, Michal Hocko wrote:
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> > Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > Reviewed-by: Bob Picco <bob.picco@oracle.com>
> 
> Considering that some HW might behave strangely and this would be rather
> hard to debug I would be tempted to mark this for stable. It should also
> be merged separately from the rest of the series.
> 
> I have just one nit below
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Agreed.

-- 
Mel Gorman
SUSE Labs
