Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08F621A1DC7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:46:29 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F08D1402B4
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:46:28 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 17 Aug 2015 15:46:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E95F52BB0051
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:46:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H5kGVv66781242
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:46:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H5jqAf004679
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2015 15:45:52 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v5 04/11] cxl: Make IRQ release idempotent
In-reply-to: <1439538087-32137-5-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
 <1439538087-32137-5-git-send-email-dja@axtens.net>
Date: Mon, 17 Aug 2015 15:45:25 +1000
Message-Id: <1439790317-sup-1627@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
