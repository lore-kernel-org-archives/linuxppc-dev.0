Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWnRn3vTHzDqm7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 19:36:37 +1000 (AEST)
Date: Tue, 15 Aug 2017 11:36:32 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 15/15] mm: debug for raw alloctor
Message-ID: <20170815093631.GD29067@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
 <20170811130831.GN30811@dhcp22.suse.cz>
 <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
 <20170814115000.GJ19063@dhcp22.suse.cz>
 <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 14-08-17 10:01:52, Pasha Tatashin wrote:
> >>However, now thinking about it, I will change it to CONFIG_MEMBLOCK_DEBUG,
> >>and let users decide what other debugging configs need to be enabled, as
> >>this is also OK.
> >
> >Actually the more I think about it the more I am convinced that a kernel
> >boot parameter would be better because it doesn't need the kernel to be
> >recompiled and it is a single branch in not so hot path.
> 
> The main reason I do not like kernel parameter is that automated test suits
> for every platform would need to be updated to include this new parameter in
> order to test it.

How does this differ from the enabling a config option and building a
separate kernel?

My primary point of the kernel option was to have something available to
debug without recompiling the kernel which is more tedious than simply
adding one option to the kernel command line.
-- 
Michal Hocko
SUSE Labs
