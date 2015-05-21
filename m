Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17D0D1A0DD2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 19:00:43 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E32E214077C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:00:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 21 May 2015 19:00:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A484C3578048
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:00:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L90V9t11599900
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:00:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L906Ye017476
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:00:07 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 brking <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 01/19] powerpc/copro: Fix faulting kernel segments
In-reply-to: <1432034556-32400-2-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-2-git-send-email-mikey@neuling.org>
Date: Thu, 21 May 2015 18:59:42 +1000
Message-Id: <1432198763-sup-3235@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
