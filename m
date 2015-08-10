Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A6DE1A0259
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 10:24:33 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 82BDC140321
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 10:24:32 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 9 Aug 2015 20:24:27 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3F1D238C8054
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Aug 2015 20:24:24 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7A0ONmZ59900008
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 00:24:24 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7A0ONVN029199
 for <linuxppc-dev@ozlabs.org>; Sun, 9 Aug 2015 20:24:23 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC
 message type
In-Reply-To: <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 10 Aug 2015 10:23:58 +1000
Message-ID: <m31tfcf0td.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> Add OPAL_MSG_OCC message definition to opal_message_type to receive
> OCC events like reset, load and throttled. Host performance can be
> affected when OCC is reset or OCC throttles the max Pstate.
> We can register to opal_message_notifier to receive OPAL_MSG_OCC type
> of message and report it to the userspace so as to keep the user
> informed about the reason for a performance drop in workloads.
>
> The reset and load OCC events are notified to kernel when FSP sends
> OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
> sent to kernel on successful completion of reset and load operation
> respectively.

How is this done on OpenPower systems? Explanation involving just what
OPAL does is likely better, rather than explaining in context of FSP,
which Linux has no real knowledge of (OPAL provides all abstraction of
it).
