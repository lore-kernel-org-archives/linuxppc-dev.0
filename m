Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBKKY1710zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 01:30:56 +1100 (AEDT)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9AEUsnU012153
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:30:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v9AEUspf032512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:30:54 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v9AEUr4P018273
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 14:30:54 GMT
Received: by mail-oi0-f54.google.com with SMTP id g125so27976077oib.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 07:30:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010140942.qe4mlby5uizt56pz@dhcp22.suse.cz>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-6-pasha.tatashin@oracle.com>
 <20171010134441.pjemi7ytaqcfm372@dhcp22.suse.cz>
 <20171010140942.qe4mlby5uizt56pz@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 10 Oct 2017 10:30:52 -0400
Message-ID: <CAOAebxtwYVDT10fGsRhGT25WzC3YVAzAm7X1bqmWnO__Cc1+Kg@mail.gmail.com>
Subject: Re: [PATCH v11 5/9] mm: zero reserved and unavailable struct pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>, daniel.m.jordan@oracle.com,
 bob.picco@oracle.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Btw. I would add your example from http://lkml.kernel.org/r/bcf24369-ac37-cedd-a264-3396fb5cf39e@oracle.com
> to do changelog
>

Will add, thank you for your review.

Pavel
