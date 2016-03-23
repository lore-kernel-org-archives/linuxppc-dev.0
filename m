Return-Path: <vaishali.thakkar@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVZ9b0qkSzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 03:03:30 +1100 (AEDT)
Subject: Re: [PATCH v2 0/6] mm/hugetlb: Fix commandline parsing behavior for
 invalid hugepagesize
To: Michal Hocko <mhocko@kernel.org>
References: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
 <20160323133011.GG7059@dhcp22.suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
 hillf.zj@alibaba-inc.com, baiyaowei@cmss.chinamobile.com,
 dingel@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
 dave.hansen@linux.intel.com, paul.gortmaker@windriver.com,
 catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@ezchip.com,
 linux-arm-kernel@lists.infradead.org, james.hogan@imgtec.com,
 linux-metag@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org
From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Message-ID: <56F2BDE3.40309@oracle.com>
Date: Wed, 23 Mar 2016 21:31:39 +0530
MIME-Version: 1.0
In-Reply-To: <20160323133011.GG7059@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 23 March 2016 07:00 PM, Michal Hocko wrote:
> On Wed 23-03-16 17:37:18, Vaishali Thakkar wrote:
>> Current code fails to ignore the 'hugepages=' parameters when unsupported
>> hugepagesize is specified. With this patchset, introduce new architecture
>> independent routine hugetlb_bad_size to handle such command line options.
>> And then call it in architecture specific code.
>>
>> Changes since v1:
>> 	- Separated different architecture specific changes in different
>> 	  patches
>> 	- CC'ed all arch maintainers
> The hugetlb parameters parsing is a bit mess but this at least makes it
> behave more consistently. Feel free to add to all patches
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> On a side note. I have received patches with broken threading - the
> follow up patches are not in the single thread under this cover email.
> I thought this was the default behavior of git send-email but maybe your
> (older) version doesn't do that. --thread option would enforce that
> (with --no-chain-reply-to) or you can set it up in the git config. IMHO
> it is always better to have the patchset in the single email thread.
>
Yes, now I have set up my git config for that. Hopefully, things will
work properly - patchset in a single thread from the next time.

Thanks.

-- 
Vaishali
