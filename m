Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8117A1A0BA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:30:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 9 Dec 2014 15:30:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E7FF72CE806C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:30:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB95UfEj36175964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:30:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB95Uftf023562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:30:41 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 sB95UfRb023555
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 16:30:41 +1100
Received: from localhost (haven.au.ibm.com [9.192.253.15])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 419EEA019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 16:30:41 +1100 (AEDT)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/7] CXL: Change contexts_lock to a mutex to fix sleep
 while atomic bug
In-reply-to: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
References: <1418026681-14787-1-git-send-email-imunsie@au.ibm.com>
Date: Tue, 09 Dec 2014 16:30:41 +1100
Message-Id: <1418102853-sup-8926@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch will definitely need to go to stable - we've run into issues
a couple of times when something has gone wrong on an AFU and ended up
taking down the whole system as a result of this bug.

Cheers,
-Ian
