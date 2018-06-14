Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415vW052WczDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 16:54:36 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id z9-v6so2973076plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:54:36 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
 by smtp.gmail.com with ESMTPSA id
 i4-v6sm6822518pfk.133.2018.06.13.23.54.32
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Jun 2018 23:54:33 -0700 (PDT)
Date: Thu, 14 Jun 2018 16:54:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB
 flush miss problem with THP
Message-ID: <20180614165429.47fde12e@roar.ozlabs.ibm.com>
In-Reply-To: <201806141310.bQbDyW9s%fengguang.wu@intel.com>
References: <20180614032256.5440-1-npiggin@gmail.com>
 <201806141310.bQbDyW9s%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Jun 2018 13:51:40 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on next-20180613]
> [cannot apply to v4.17]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-64s-radix-Fix-MADV_-FREE-DONTNEED-TLB-flush-miss-problem-with-THP/20180614-114728
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: microblaze-nommu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=microblaze 

Ooops, absent mindedly edited a header without thinking it's not
powerpc specific. Will fix it somehow.
