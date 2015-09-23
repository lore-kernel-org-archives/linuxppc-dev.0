Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E0001A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:21:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 23 Sep 2015 13:21:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AD26A2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:21:50 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8N3Lg7K30736436
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:21:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8N3LI5R024873
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 13:21:18 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] cxl: Fix lockdep warning while creating afu_err_buff
 attribute
In-reply-to: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1442977679-4468-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 23 Sep 2015 13:20:53 +1000
Message-Id: <1442978421-sup-3476@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for fixing that Vaibhav :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
