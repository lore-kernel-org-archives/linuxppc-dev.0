Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3868E1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 03:01:10 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 11 Nov 2015 02:01:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 766892CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 03:01:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAAG0euF36765868
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 03:00:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAAG0Tuc017862
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 03:00:31 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Scott Wood <scottwood@freescale.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH V4 00/31] powerpc/mm: Update page table format for book3s
 64
In-Reply-To: <CAOJe8K2NhFiaHdOSUnAmEh_MxinuTp=cAcCRAcjCyFPJN3hr6g@mail.gmail.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAOJe8K1cnLmDdnV-f4XNiJjoK2w59SwEi8vNy2i6yLyOKYxCVQ@mail.gmail.com>
 <87a8rarudb.fsf@linux.vnet.ibm.com>
 <CAOJe8K256Kr46VVZEPnbMR1Du4cuyS1hhYEh1FmGBgmDxcixJw@mail.gmail.com>
 <87twp3u13i.fsf@linux.vnet.ibm.com>
 <CAOJe8K2NhFiaHdOSUnAmEh_MxinuTp=cAcCRAcjCyFPJN3hr6g@mail.gmail.com>
Date: Tue, 10 Nov 2015 21:30:08 +0530
Message-ID: <87fv0d975j.fsf@linux.vnet.ibm.com>
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

Denis Kirjanov <kda@linux-powerpc.org> writes:

> On 11/3/15, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Denis Kirjanov <kda@linux-powerpc.org> writes:
>>
........
..........

>> Why not use
>>
>> The patch series can also be found at
>> https://github.com/kvaneesh/linux.git book3s-pte-format
>> https://github.com/kvaneesh/linux/commits/book3s-pte-format
>
> I've started playing with your changes.
> Also I want to run Mel Gorman's mm tests[0] but it needs some
> work to adapt them to run.
>

I did post one config number here

http://article.gmane.org/gmane.linux.ports.ppc.embedded/88548

-aneesh
