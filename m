Return-Path: <mhocko@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBK066FQ3zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 01:15:50 +1100 (AEDT)
Date: Tue, 10 Oct 2017 16:15:47 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v11 0/9] complete deferred page initialization
Message-ID: <20171010141547.zpdptsccsblyw634@dhcp22.suse.cz>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009221931.1481-1-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Btw. thanks for your persistance and willingness to go over all the
suggestions which might not have been consistent btween different
versions. I believe this is a general improvement in the early
initialization code. We do not rely on an implicit zeroing which just
happens to work by a chance. The perfomance improvements are a bonus on
top.

Thanks, good work!
-- 
Michal Hocko
SUSE Labs
