Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91C791A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 11:25:52 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 15 Jun 2015 19:25:50 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EF2861FF0030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 19:16:57 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5G1PmQl38928588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 18:25:48 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5G1PmSX001723
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 19:25:48 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: fix construction of opal PRD messages
In-Reply-To: <1434360334.29351.605847485345.1.gpush@pablo>
References: <1434360334.29351.605847485345.1.gpush@pablo>
Date: Tue, 16 Jun 2015 11:25:45 +1000
Message-ID: <m3mw00bg12.fsf@oc8180480414.ibm.com>
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

Jeremy Kerr <jk@ozlabs.org> writes:
> We currently have a bug in the PRD code, where the contents of an
> incoming message (beyond the header) will be overwritten by the list
> item manipulations when adding to to the prd_msg_queue.
>
> This change reorders struct opal_prd_msg_queue_item, so that the
> message body doesn't overlap the list_head.
>
> We also clarify the memcpy of the message, as we're copying unnecessary
> bytes at the end of the message data.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
