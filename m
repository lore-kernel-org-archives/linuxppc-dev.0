Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7972C1A1DD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:48:02 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39D1C1402B6
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:48:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 17 Aug 2015 15:48:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 561EE2BB0054
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:47:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H5lq504522438
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:48:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H5lQEW028616
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:47:26 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v5 07/11] cxl: Refactor AFU init/teardown
In-reply-to: <1439538087-32137-8-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
 <1439538087-32137-8-git-send-email-dja@axtens.net>
Date: Mon, 17 Aug 2015 15:47:00 +1000
Message-Id: <1439790393-sup-3503@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
