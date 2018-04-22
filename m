Return-Path: <srs0=3rgh=hl=gmail.com=nicholas.piggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40TCRz1pH3zF1sZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 11:58:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40TCRz1Dw5z8tGJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 11:58:39 +1000 (AEST)
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40TCRx6x28z9s15
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2018 11:58:36 +1000 (AEST)
Received: by mail-pg0-x235.google.com with SMTP id l12so5922808pgp.11
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2018 18:58:36 -0700 (PDT)
Date: Sun, 22 Apr 2018 11:58:16 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Ananth Narayan
 <ananth@in.ibm.com>, kernelfans@gmail.com, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Hari Bathini
 <hbathini@linux.vnet.ibm.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/7] powerpc/fadump: Move the metadata region to
 start of the reserved area.
Message-ID: <20180422115816.701d0837@roar.ozlabs.ibm.com>
In-Reply-To: <152420065839.31037.9373191008433546810.stgit@jupiter.in.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
 <152420065839.31037.9373191008433546810.stgit@jupiter.in.ibm.com>
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

On Fri, 20 Apr 2018 10:34:18 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Currently the metadata region that holds crash info structure and ELF core
> header is placed towards the end of reserved memory area. This patch places
> it at the beginning of the reserved memory area. It also introduces
> additional dump section called metadata section to communicate location
> of metadata region to 2nd kernel. This patch also maintains the
> compatibility between production/capture kernels irrespective of their
> kernel versions. Both combination older/newer and newer/older works fine.

Trying to look at the patches it might help me if you document reasons
for why this change is made changelog, even if it may be obvious to
someone who knows the code better.

I thought you could include the documentation change in this patch as
well, but maybe that's a matter of preference.

Thanks,
Nick
