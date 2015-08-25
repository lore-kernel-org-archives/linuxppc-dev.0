Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3520D1A0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:27:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 25 Aug 2015 17:27:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 146E02CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:27:52 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7P7Raf454460448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:27:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7P7RJV9003715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:27:19 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] cxl: Release irqs if memory allocation fails
In-reply-to: <1440480888-7885-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1440480888-7885-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Tue, 25 Aug 2015 17:26:46 +1000
Message-Id: <1440487594-sup-966@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
