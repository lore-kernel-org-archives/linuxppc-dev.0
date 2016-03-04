Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6C4F1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 14:51:09 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 4 Mar 2016 13:51:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 694EE2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 14:50:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u243omwh49545282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 14:50:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u243oNtk012385
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 14:50:24 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mpe <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Ignore probes for virtual afu pci devices
In-reply-to: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1456724453-10152-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Fri, 04 Mar 2016 14:49:53 +1100
Message-Id: <1457063382-sup-7297@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
