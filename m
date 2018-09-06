Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425hK85HMWzF0Q6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 23:30:36 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w86DUAwN094519
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2018 09:30:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mb40qkh8e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2018 09:30:33 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Thu, 6 Sep 2018 14:30:31 +0100
Date: Thu, 6 Sep 2018 16:30:23 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Greentime Hu <green.hu@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org,
 mingo@redhat.com, mpe@ellerman.id.au, mhocko@suse.com,
 paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
 tony.luck@intel.com, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <CAEbi=3dKL1zOYc0DC3yXm=7srw6tUfx-JR=o9n4pVrGp+Sosug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAEbi=3dKL1zOYc0DC3yXm=7srw6tUfx-JR=o9n4pVrGp+Sosug@mail.gmail.com>
Message-Id: <20180906133023.GL27492@rapoport-lnx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2018 at 10:33:48AM +0800, Greentime Hu wrote:
> Mike Rapoport <rppt@linux.vnet.ibm.com> 於 2018年9月6日 週四 上午12:04寫道：
> >
> > Hi,
> >
> > These patches switch early memory managment to use memblock directly
> > without any bootmem compatibility wrappers. As the result both bootmem and
> > nobootmem are removed.
> >
> > There are still a couple of things to sort out, the most important is the
> > removal of bootmem usage in MIPS.
> >
> > Still, IMHO, the series is in sufficient state to post and get the early
> > feedback.
> >
> > The patches are build-tested with defconfig for most architectures (I
> > couldn't find a compiler for nds32 and unicore32) and boot-tested on x86
> > VM.
> >
> Hi Mike,
> 
> There are nds32 toolchains.
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-nds32le-linux.tar.gz
> https://github.com/vincentzwc/prebuilt-nds32-toolchain/releases/download/20180521/nds32le-linux-glibc-v3-upstream.tar.gz

Thanks!
 
> Sorry, we have no qemu yet.
> 

-- 
Sincerely yours,
Mike.
