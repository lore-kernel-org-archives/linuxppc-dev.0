Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqvl91ZkCzF0b1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 08:16:20 +1100 (AEDT)
Subject: Re: [PATCH v12 3/3] mm, x86, powerpc: display pkey in smaps only if
 arch supports pkeys
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com,
 akpm@linux-foundation.org
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
 <1519257138-23797-4-git-send-email-linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2a7737cf-a5ba-c814-fdc7-45b5cdd47376@intel.com>
Date: Mon, 26 Feb 2018 13:16:16 -0800
MIME-Version: 1.0
In-Reply-To: <1519257138-23797-4-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 03:52 PM, Ram Pai wrote:
> Currently the  architecture  specific code is expected to
> display  the  protection  keys  in  smap  for a given vma.
> This can lead to redundant code and possibly to divergent
> formats in which the key gets displayed.
> 
> This  patch  changes  the implementation. It displays the
> pkey only if the architecture support pkeys, i.e
> arch_pkeys_enabled() returns true.  This patch
> provides x86 implementation for arch_pkeys_enabled().
> 
> x86 arch_show_smap() function is not needed anymore.
> Deleting it.

This looks fine to me.  Thanks for doing these, Ram.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
