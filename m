Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 566E41A0514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 02:20:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 20 Aug 2015 02:20:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B05D52BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 02:20:39 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JGKUvZ59310290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 02:20:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JGK5KJ019528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 02:20:06 +1000
Message-ID: <55D4ACA1.30801@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 21:49:45 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, stewart@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v9 3/3] leds/powernv: Add driver for PowerNV platform
References: <1439980886-16360-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1439980886-16360-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55D478AF.4080009@samsung.com>
In-Reply-To: <55D478AF.4080009@samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2015 06:08 PM, Jacek Anaszewski wrote:
> Hi Vasant,

Hello Jacek,

> 
> I've found two superfluous lines. Please find my remarks below.

Thanks for the review. I will fix both issues and will send v10 soon.

-Vasant
