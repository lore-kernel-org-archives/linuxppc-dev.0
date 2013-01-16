Return-Path: <mhocko@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30BB12C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 01:15:12 +1100 (EST)
Date: Wed, 16 Jan 2013 15:15:08 +0100
From: Michal Hocko <mhocko@suse.cz>
To: Lin Feng <linfeng@cn.fujitsu.com>
Subject: Re: [PATCH v3 0/2] memory-hotplug: introduce
 CONFIG_HAVE_BOOTMEM_INFO_NODE and revert register_page_bootmem_info_node()
 when platform not support
Message-ID: <20130116141508.GF343@dhcp22.suse.cz>
References: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, aquini@redhat.com, heiko.carstens@de.ibm.com,
 tangchen@cn.fujitsu.com, dhowells@redhat.com, paul.gortmaker@windriver.com,
 paulus@samba.org, jbeulich@suse.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 mingo@redhat.com, gerald.schaefer@de.ibm.com, fenghua.yu@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, mel@csn.ul.ie, tglx@linutronix.de,
 kamezawa.hiroyu@jp.fujitsu.com, tony.luck@intel.com, laijs@cn.fujitsu.com,
 linux-mm@kvack.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 minchan@kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 16-01-13 16:14:17, Lin Feng wrote:
[...]
> changeLog v2->v3:
> 1) patch 1/2:
> - Rename the patch title to conform it's content.
> - Update memory_hotplug.h and remove the misleading TODO pointed out by Michal.
> 2) patch 2/2:
> - New added, remove unimplemented functions suggested by Michal.

I think that both patches should be merged into one and put to Andrew's
queue as
memory-hotplug-implement-register_page_bootmem_info_section-of-sparse-vmemmap-fix.patch
rather than a separate patch.
-- 
Michal Hocko
SUSE Labs
