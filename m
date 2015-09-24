Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E84F81A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 13:18:38 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCA54140281
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 13:18:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 24 Sep 2015 13:18:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACF1E3578052
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 13:18:33 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8O3ILDK23134458
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 13:18:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8O3I02R011105
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 13:18:01 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>, mikey <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Panic on unhandled Machine Check
In-reply-to: <1442990508-10199-1-git-send-email-dja@axtens.net>
References: <1442990508-10199-1-git-send-email-dja@axtens.net>
Date: Thu, 24 Sep 2015 13:17:35 +1000
Message-Id: <1443064592-sup-3691@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Daniel.

Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>
