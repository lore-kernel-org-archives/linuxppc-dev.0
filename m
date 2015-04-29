Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B2241A186C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:27:52 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 30 Apr 2015 01:27:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 869582BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:27:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3TFRbBO45089022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:27:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3TFRBkl003279
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:27:11 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Implement an ioctl to fetch afu card-id,
 offset-id and mode
In-reply-to: <1430302643-10772-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1430302643-10772-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 29 Apr 2015 10:26:44 -0500
Message-Id: <1430321041-sup-909@delenn.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
