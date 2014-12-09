Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F01761A05D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:31:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 9 Dec 2014 15:31:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0A698357807C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:31:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB95Vnh227000934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:31:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB95VnFm025556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:31:49 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 sB95VnaT025548
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:31:49 +1100
Received: from localhost (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 57618A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:31:49 +1100 (AEDT)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/7] CXL: Add timeout to process element commands
In-reply-to: <1418026681-14787-2-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-2-git-send-email-imunsie@au.ibm.com>
Date: Tue, 09 Dec 2014 16:31:49 +1100
Message-Id: <1418103045-sup-899@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one needs to go to stable - I've hit it a couple of times while
testing bad AFUs and it results in an unkillable process.

Cheers,
-Ian
