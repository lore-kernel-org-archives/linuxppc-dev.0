Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97BDF1A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 14:17:10 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 22:17:08 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 17E5419D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 22:08:00 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t814G35I43254006
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 21:16:03 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t814H46H003953
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 22:17:04 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH] asm/opal-api: Assign numbers to OPAL_MSG macros of enum
 opal_msg_type
In-Reply-To: <1441063363-24107-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1441063363-24107-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Tue, 01 Sep 2015 14:17:01 +1000
Message-ID: <m3fv2ykc3m.fsf@oc8180480414.ibm.com>
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

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
> This patch assigns numbers to OPAL_MSG macros of enum opal_msg_type
> to prevent accidental insertion of any new value in between and thus
> break OPAL API. This is also helpful while backporting mainline kernel
> changes to distros which run downlevel kernel and thus don't have all
> OPAL messages defined, avoiding unnecessary bugs due to enum values
> order mismatch.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>

Merging corresponding firmware patch now.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
