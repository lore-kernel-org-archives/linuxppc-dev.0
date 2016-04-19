Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpvvM1YvqzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:17:51 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 19 Apr 2016 16:17:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B24FD2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:17:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J6Hai057933938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:17:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J6HC2T024431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:17:12 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 clombard <clombard@linux.vnet.ibm.com>,
 fbarrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: static-ify variables to fix sparse warnings
In-reply-to: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Tue, 19 Apr 2016 16:16:46 +1000
Message-Id: <1461046589-sup-920@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
