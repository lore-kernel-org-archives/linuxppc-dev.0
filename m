Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzT2H0KCtzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 14:38:30 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 3 May 2016 14:38:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B84E32BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 14:38:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u434cI8G50855974
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 14:38:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u434bsbW005607
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 14:37:54 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>
Cc: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 fbarrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH V2] cxl: Check periodically the coherent platform
 function's state
In-reply-to: <1461332362-5309-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1461332362-5309-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Tue, 03 May 2016 14:36:59 +1000
Message-Id: <1462250122-sup-631@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
