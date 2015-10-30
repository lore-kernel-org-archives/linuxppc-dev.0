Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD1B61A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 13:57:53 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 30 Oct 2015 12:57:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4BCD9357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 13:57:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U2vgps27525304
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 13:57:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U2vGCb030402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 13:57:16 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <frederic.barrat@fr.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
In-reply-to: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
Date: Fri, 30 Oct 2015 13:56:48 +1100
Message-Id: <1446173801-sup-3670@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
