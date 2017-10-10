Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBPYQ2m1gzDr4W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:41:29 +1100 (AEDT)
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9AHfQgn017015
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:41:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v9AHfQb7001515
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:41:26 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v9AHfQ4e001278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:41:26 GMT
Received: by mail-oi0-f49.google.com with SMTP id w197so41885870oif.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 10:41:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010171047.GC2517@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 10 Oct 2017 13:41:24 -0400
Message-ID: <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 Michal Hocko <mhocko@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
 sam@ravnborg.org, mgorman@techsingularity.net,
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

Hi Will,

Ok, I will add your patch at the end of my series.

Thank you,
Pavel

>
> I was thinking that you could just add my patch to the end of your series
> and have the whole lot go up like that. If you want to merge it with your
> patch, I'm fine with that too.
>
> Will
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
