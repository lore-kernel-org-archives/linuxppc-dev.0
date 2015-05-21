Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CE2C1A0CAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 19:11:19 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13A1B14078C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:11:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 21 May 2015 19:11:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 384682BB0047
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:11:15 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L9B78e21364752
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:11:15 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L9Agdk001669
 for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2015 19:10:42 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 brking <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 08/19] cxl: Dump debug info on the AFU configuration record
In-reply-to: <1432034556-32400-9-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-9-git-send-email-mikey@neuling.org>
Date: Thu, 21 May 2015 19:10:17 +1000
Message-Id: <1432199409-sup-289@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
