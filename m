Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBNpS1m1HzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 04:07:43 +1100 (AEDT)
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
 by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9AH7c29029061
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:07:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v9AH7a6e029790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:07:37 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v9AH7ae8022664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 17:07:36 GMT
Received: by mail-oi0-f45.google.com with SMTP id h200so19313544oib.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 10:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010155619.GA2517@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 10 Oct 2017 13:07:35 -0400
Message-ID: <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
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

Thank you for doing this work. How would you like to proceed?

- If you OK for my series to be accepted as-is, so your patch can be
added later on top, I think, I need an ack from you for kasan changes.
- Otherwise, I can replace: 4267aaf1d279 arm64/kasan: add and use
kasan_map_populate() in my series with code from your patch.

Thank you,
Pavel
