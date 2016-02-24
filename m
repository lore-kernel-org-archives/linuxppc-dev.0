Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5973B1A0347
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 17:31:16 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 12:01:12 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1O6VAc21311086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:01:10 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OC0SfO017211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 17:30:28 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/powernv: Add powernv_defconfig
In-Reply-To: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
References: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
Date: Wed, 24 Feb 2016 12:01:05 +0530
Message-ID: <87wppu7h7a.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeremy,

Jeremy Kerr <jk@ozlabs.org> writes:

> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_GENERIC=y

Would recommend using CONFIG_RTC_DRV_OPAL=y instead of using the generic
RTC driver.

Cheers,
~ Vaibhav
