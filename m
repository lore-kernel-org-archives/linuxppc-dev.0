Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1Nff2wvSzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 17:28:10 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 6 May 2016 17:28:07 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1A6FD2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 17:28:05 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u467RumP6095144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 17:28:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u467RWxL021917
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 17:27:32 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
Subject: Re: [PATCH] cxl: Add kernel API to allow a context to operate with
 relocate disabled
In-reply-to: <572A1E30.2020306@linux.vnet.ibm.com>
References: <1462344882-1638-1-git-send-email-imunsie@au.ibm.com>
 <572A1E30.2020306@linux.vnet.ibm.com>
Date: Fri, 06 May 2016 17:27:06 +1000
Message-Id: <1462519595-sup-2965@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sure thing, that actually simplifies things a great deal. Testing now
and will resend shortly :)

-Ian
