Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJJ5Z21X4zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 21:55:30 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vJJ5Y5CHQz9s6s
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2017 21:55:29 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 194so14905133pgd.0
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Feb 2017 02:55:29 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 8 Feb 2017 16:25:20 +0530
To: kbuild test robot <lkp@intel.com>
Cc: Balbir Singh <bsingharora@gmail.com>, kbuild-all@01.org,
 mpe@ellerman.id.au, linuxppc-dev@ozlabs.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/xmon: Apply binutils changes to upgrade
 disassembly
Message-ID: <20170208105520.GE17068@localhost.localdomain>
References: <20170202050344.6825-3-bsingharora@gmail.com>
 <201702021636.pHsYmBR1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201702021636.pHsYmBR1%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2017 at 04:16:41PM +0800, kbuild test robot wrote:
> Hi Balbir,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.10-rc6 next-20170201]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 

FYI for everyone

This patch does not compile, its documented in the patchset
and breaks bisect. The organization of this patch is driven
more by licensing constraints and modularization

Balbir
