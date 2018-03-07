Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx1Zj56TrzF1hF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 15:56:45 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w274s931121460
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 23:56:42 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gj3scarbq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 23:56:42 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 04:56:40 -0000
Subject: Re: [PATCH] powerpc/perf: Fix kernel address leaks via Sampling
 registers
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
References: <1520165709-20524-1-git-send-email-maddy@linux.vnet.ibm.com>
 <201803062210.ahTRkTqj%fengguang.wu@intel.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 10:26:34 +0530
MIME-Version: 1.0
In-Reply-To: <201803062210.ahTRkTqj%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <64740f90-d9d2-0207-950c-8f26651d63d7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 06 March 2018 08:36 PM, kbuild test robot wrote:
> Hi Michael,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on v4.16-rc1]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/powerpc-perf-Fix-kernel-address-leaks-via-Sampling-registers/20180306-041036
> config: powerpc-pmac32_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=powerpc

My bad should have added the ppmu->flag or config check to avoid this
in 32bit case. Will respin it.

Maddy

> All errors (new ones prefixed by >>):
>
>     {standard input}: Assembler messages:
>>> {standard input}:2476: Error: unsupported relocation against SPRN_SDAR
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
