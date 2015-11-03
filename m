Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 979EB1A0BC1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:27:06 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 Nov 2015 08:27:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 579262BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:27:03 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA3MQn9i30015590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:26:57 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3MQU5Z019632
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:26:30 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 stable <stable@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix struct pid leak when attaching a process through
 kernel API
In-reply-to: <1446553215-18273-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1446553215-18273-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 04 Nov 2015 09:26:04 +1100
Message-Id: <1446589556-sup-8868@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
