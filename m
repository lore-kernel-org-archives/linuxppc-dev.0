Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y62Yt6GYpzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 02:11:46 +1100 (AEDT)
Subject: Re: [PATCH v9 02/12] sparc64/mm: setting fields in deferred pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-3-pasha.tatashin@oracle.com>
 <20171003122823.mdzkhxs4xza7sb2w@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <3c410186-0af9-dae8-84eb-8f4d4651d355@oracle.com>
Date: Tue, 3 Oct 2017 11:10:35 -0400
MIME-Version: 1.0
In-Reply-To: <20171003122823.mdzkhxs4xza7sb2w@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> As you separated x86 and sparc patches doing essentially the same I
> assume David is going to take this patch?

Correct, I noticed that usually platform specific changes are done in 
separate patches even if they are small. Dave already Acked this patch. 
So, I do not think it should be separated from the rest of the patches 
when this projects goes into mm-tree.

> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pasha
