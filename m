Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 610EC1A2C5E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 15:13:40 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33D981401B5
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:13:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 15 Sep 2015 15:13:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ECF412BB0055
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:13:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F5DO2731850702
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:13:32 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F5D3DR018108
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:13:03 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH v2] cxl: Fix unbalanced pci_dev_get in cxl_probe
In-reply-to: <1442293447-1843-1-git-send-email-dja@axtens.net>
References: <1442293447-1843-1-git-send-email-dja@axtens.net>
Date: Tue, 15 Sep 2015 15:12:38 +1000
Message-Id: <1442293950-sup-3427@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
