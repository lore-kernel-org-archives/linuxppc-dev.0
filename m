Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47A521A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:05:27 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 3 Mar 2016 14:05:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5A0402BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 15:05:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2345Fdm29425666
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:05:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2344omP013584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2016 15:04:51 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: "michael.neuling" <michael.neuling@au1.ibm.com>, mpe <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 10/18] cxl: New hcalls to support cxl adapters
In-reply-to: <1456244519-18934-11-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-11-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Thu, 03 Mar 2016 15:04:25 +1100
Message-Id: <1456977598-sup-9016@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#define H_CONTROL_CA_FUNCTION_SUSPEND_PROCESS         2 /* suspend a process from being executed */
> +#define H_CONTROL_CA_FUNCTION_RESUME_PROCESS          3 /* resume a process to be executed */

Thanks for fixing that :)

> +static char *afu_op_names[] = {
...

Much nicer, thanks :)

> +    /*
> +     * We want to regroup up to 4 integers per line, which means they
> +     * need to be in the same pr_devel() statement
> +     */

OK

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
