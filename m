Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 559691A082E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:50:06 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:50:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AD2E62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:49:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3np0540108050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:49:59 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3nR8A020776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:49:27 +1100
Message-ID: <56C3EDB4.50306@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 09:19:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11_RESEND 00/10] powerpc/perf: Enable SW branch filters
References: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
 <56C31F38.1030702@c-s.fr>
In-Reply-To: <56C31F38.1030702@c-s.fr>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2016 06:38 PM, Christophe Leroy wrote:
> Your patches seem to be under review in Patchwork, see
> https://patchwork.ozlabs.org/patch/526275/
> Why do you resend it ?

Its been 3-4 months I had posted last version V11. Wanted to check if it all
works till now. So rebased the series, tested and resent.
