Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJ78j5TygzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 12:13:25 +1100 (AEDT)
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9K1DMPi022020
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:13:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v9K1DJ0Q031085
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:13:20 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v9K1DJ5a028065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:13:19 GMT
Received: by mail-oi0-f46.google.com with SMTP id c77so17851530oig.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 18:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019165921.de4224c8e627b1477cfb50de@linux-foundation.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-10-pasha.tatashin@oracle.com>
 <20171019165921.de4224c8e627b1477cfb50de@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 19 Oct 2017 21:13:18 -0400
Message-ID: <CAOAebxswpsLEtvZXwj0Qk62=5KC6Xh2ewaHrWJVbo_O=9Hye9Q@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] mm: stop zeroing memory during allocation in
 vmemmap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Michal Hocko <mhocko@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Bob Picco <bob.picco@oracle.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This looks good to me, thank you Andrew.

Pavel
