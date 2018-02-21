Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmNHk6RgZzF1Fd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 14:28:50 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1L3Oedn055722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 22:28:48 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g8xe54g5y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 22:28:48 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 20 Feb 2018 20:28:47 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, skiboot@lists.ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 (skiboot)] dt: add /cpus/ibm,
 powerpc-cpu-features device tree bindings
In-Reply-To: <20180216034042.7356-1-npiggin@gmail.com>
References: <20180216034042.7356-1-npiggin@gmail.com>
Date: Wed, 21 Feb 2018 14:28:41 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87sh9vvx5i.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> This is a new CPU feature advertising interface that is fine-grained,
> extensible, aware of privilege levels, and gives control of features
> to all levels of the stack (firmware, hypervisor, and OS).
>
> The design and binding specification is described in detail in doc/.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
>
> - Fold branch-v3 into fixed-point-v3, as pointed out by Segher they
>   are all fixed point facilities.
>
> - Fixed typo (Segher)
>
>  core/Makefile.inc                                  |   2 +-
>  core/cpufeatures.c                                 | 921 +++++++++++++++++++++
>  core/device.c                                      |   7 +
>  core/init.c                                        |   1 +
>  .../ibm,powerpc-cpu-features/binding.txt           | 245 ++++++
>  .../ibm,powerpc-cpu-features/design.txt            | 157 ++++
>  include/device.h                                   |   1 +
>  include/skiboot.h                                  |   5 +
>  8 files changed, 1338 insertions(+), 1 deletion(-)
>  create mode 100644 core/cpufeatures.c
>  create mode 100644 doc/device-tree/ibm,powerpc-cpu-features/binding.txt
>  create mode 100644
>  doc/device-tree/ibm,powerpc-cpu-features/design.txt

Merged to master as of 7f4c8e8ce0b78ca046643d7f4f63d81f4fd11746 and has
made it into -rc4

-- 
Stewart Smith
OPAL Architect, IBM.
