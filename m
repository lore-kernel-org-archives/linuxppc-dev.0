Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJJph3YVlzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 22:27:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, kbuild test robot <lkp@intel.com>
Cc: Balbir Singh <bsingharora@gmail.com>, kbuild-all@01.org,
 linuxppc-dev@ozlabs.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/xmon: Apply binutils changes to upgrade
 disassembly
In-Reply-To: <20170208105520.GE17068@localhost.localdomain>
References: <20170202050344.6825-3-bsingharora@gmail.com>
 <201702021636.pHsYmBR1%fengguang.wu@intel.com>
 <20170208105520.GE17068@localhost.localdomain>
Date: Wed, 08 Feb 2017 22:27:36 +1100
Message-ID: <871sv8apnb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On Thu, Feb 02, 2017 at 04:16:41PM +0800, kbuild test robot wrote:
>> Hi Balbir,
>> 
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.10-rc6 next-20170201]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>> 
>
> FYI for everyone
>
> This patch does not compile, its documented in the patchset
> and breaks bisect. The organization of this patch is driven
> more by licensing constraints and modularization

I was thinking what I'll do is just disable CONFIG_XMON_DISASSEMBLY
before patch 1, and then turn it on again in patch 3.

That way the build won't break at any point, just that code will be
unbuildable for a couple of commits, which is fine.

cheers
