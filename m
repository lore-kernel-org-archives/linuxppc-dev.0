Return-Path: <mstsxfx@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVVml5XHGzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 00:30:15 +1100 (AEDT)
Received: by mail-wm0-f66.google.com with SMTP id r129so4417928wmr.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 06:30:15 -0700 (PDT)
Date: Wed, 23 Mar 2016 14:30:11 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com,
 mike.kravetz@oracle.com, hillf.zj@alibaba-inc.com,
 baiyaowei@cmss.chinamobile.com, dingel@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
 paul.gortmaker@windriver.com, catalin.marinas@arm.com,
 will.deacon@arm.com, cmetcalf@ezchip.com,
 linux-arm-kernel@lists.infradead.org, james.hogan@imgtec.com,
 linux-metag@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH v2 0/6] mm/hugetlb: Fix commandline parsing behavior for
 invalid hugepagesize
Message-ID: <20160323133011.GG7059@dhcp22.suse.cz>
References: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 23-03-16 17:37:18, Vaishali Thakkar wrote:
> Current code fails to ignore the 'hugepages=' parameters when unsupported
> hugepagesize is specified. With this patchset, introduce new architecture
> independent routine hugetlb_bad_size to handle such command line options.
> And then call it in architecture specific code.
> 
> Changes since v1:
> 	- Separated different architecture specific changes in different
> 	  patches
> 	- CC'ed all arch maintainers

The hugetlb parameters parsing is a bit mess but this at least makes it
behave more consistently. Feel free to add to all patches
Acked-by: Michal Hocko <mhocko@suse.com>

On a side note. I have received patches with broken threading - the
follow up patches are not in the single thread under this cover email.
I thought this was the default behavior of git send-email but maybe your
(older) version doesn't do that. --thread option would enforce that
(with --no-chain-reply-to) or you can set it up in the git config. IMHO
it is always better to have the patchset in the single email thread.

-- 
Michal Hocko
SUSE Labs
