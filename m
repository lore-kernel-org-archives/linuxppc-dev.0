Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 959CE1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:39:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 9 Dec 2014 15:39:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 81AC52BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:39:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB95dL1841222256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:39:21 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB95dLmf006365
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:39:21 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 sB95dKAI006358
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:39:20 +1100
Received: from localhost (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B45AAA019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:39:20 +1100 (AEDT)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5/7] CXL: Disable AFU debug flag
In-reply-to: <1418026681-14787-5-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-5-git-send-email-imunsie@au.ibm.com>
Date: Tue, 09 Dec 2014 16:39:20 +1100
Message-Id: <1418103265-sup-9241@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one would be nice to go to stable, but I'm not sure it really meets
the rules. It could be a problem for userspace error paths checking the
result of MMIO reads, but only if the AFU has actually been unexpectedly
disabled somehow yet the PSL is still responding...

I don't think this is a high priority to go to stable unless it starts
causing problems for someone.

Cheers,
-Ian
