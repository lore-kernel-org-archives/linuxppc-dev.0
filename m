Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE2D1A0146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 08:03:33 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 16:03:31 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 835E9C90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 15:54:39 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t19L3RPN27066372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:03:27 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t19L3PT6008047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 16:03:26 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powernv: Add OPAL soft-poweroff routine
In-Reply-To: <1422600188-27488-1-git-send-email-joel@jms.id.au>
References: <1422600188-27488-1-git-send-email-joel@jms.id.au>
Date: Tue, 10 Feb 2015 08:03:22 +1100
Message-ID: <m3pp9iol0l.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joel Stanley <joel@jms.id.au> writes:
> Register a notifier for a OPAL message indicating that the machine
> should prepare itself for a graceful power off.
>
> OPAL will tell us if the power off is a reboot or shutdown, but for now
> we perform the same orderly_poweroff action.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

I merged the firmware side of things, this looks like it implements what
firmware exports.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
