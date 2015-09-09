Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B9E01A2758
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 17:02:26 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 027DD140761
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2015 17:02:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 9 Sep 2015 17:02:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2C36D3578055
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2015 17:02:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8972ClL30736608
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2015 17:02:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8971oCH007314
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2015 17:01:50 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] cxl: Fix unbalanced pci_dev_get in cxl_probe
In-reply-to: <1441775845-25870-1-git-send-email-dja@axtens.net>
References: <1441775845-25870-1-git-send-email-dja@axtens.net>
Date: Wed, 09 Sep 2015 17:01:25 +1000
Message-Id: <1441782059-sup-7551@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Daniel :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
