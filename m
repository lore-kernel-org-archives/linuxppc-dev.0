Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6ED201A017D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:24:41 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10F491401EF
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:24:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 14 Aug 2015 15:24:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4923A2CE8057
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:24:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E5OTfi64815152
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:24:37 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E5O4p9019238
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:24:04 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>, cyrilbur <cyrilbur@gmail.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v4 02/11] cxl: Drop commands if the PCI channel is not in
 normal state
In-reply-to: <1439439089-25151-3-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
 <1439439089-25151-3-git-send-email-dja@axtens.net>
Date: Fri, 14 Aug 2015 15:23:38 +1000
Message-Id: <1439529329-sup-7848@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Excerpts from Daniel Axtens's message of 2015-08-13 14:11:20 +1000:
> +    /* Only warn if we detached while the link was OK.

Only because mpe is sure to pick this up (I personally don't mind) -
block comments should start with /* on a line by itself.

> +        /* If the adapter has gone down, we can assume that we
...
> +    /* We could be asked to terminate when the hw is down. That
...
> +    /* We could be asked to remove when the hw is down. Again, if
...
> +    /* If the adapter has gone away, we can't get any meaningful
...
> +    /* Config space IO is based on phb->cfg_addr, which is based on

Ditto.

Cheers,
-Ian
