Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 601A11A0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:35:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 9 Dec 2014 15:35:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 407D33578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:35:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB95Z2np39780380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:35:10 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB95Ybji012945
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:34:37 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 sB95YbaN012486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:34:37 +1100
Received: from localhost (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 80CEDA019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:34:13 +1100 (AEDT)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/7] CXL: Fix leaking interrupts if attach process fails
In-reply-to: <1418026681-14787-3-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
 <1418026681-14787-3-git-send-email-imunsie@au.ibm.com>
Date: Tue, 09 Dec 2014 16:34:13 +1100
Message-Id: <1418103120-sup-2848@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This one would be nice to go to stable, but I'm not sure if it's
critical enough to justify it since it only reduces the number of
available interrupts (and therefore, contexts) that can be used by the
card (so, maybe you can only run 507 contexts simultaneously instead of
509)...

Cheers,
-Ian
