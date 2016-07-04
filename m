Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjVQ40H4XzDqp3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 11:52:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u641mfnM026024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jul 2016 21:52:25 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mcbe3n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jul 2016 21:52:25 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 11:52:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DE6F12BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 11:52:19 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u641qJN013435344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 11:52:19 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u641qJE4009257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 11:52:19 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 tgrobeck <tgrobeck@us.ibm.com>, fbarrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cxl: Ignore CAPI adapters misplaced in switched slots
In-reply-to: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1467372772-9422-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2016 11:51:47 +1000
Message-Id: <1467597096-sup-5605@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
