Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 932551A026D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:34:27 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E6F71401EF
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:34:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 14 Aug 2015 16:34:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 72CD52BB005C
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:34:24 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6YEvs27721906
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:34:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6XpI0018515
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 16:33:52 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>, cyrilbur <cyrilbur@gmail.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v4 11/11] cxl: Add CONFIG_CXL_EEH symbol
In-reply-to: <1439439089-25151-12-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
 <1439439089-25151-12-git-send-email-dja@axtens.net>
Date: Fri, 14 Aug 2015 16:33:25 +1000
Message-Id: <1439533921-sup-1286@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once cxlflash has been merged we might drop this, but until then:

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
