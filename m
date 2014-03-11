Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7BD32C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 10:34:23 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 12 Mar 2014 05:04:18 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 1EFC81258044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 05:06:30 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2BNYAO34456950
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 05:04:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2BNYEXB002638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Mar 2014 05:04:14 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Infrastructure to support OPAL async
 completion
In-Reply-To: <20140307053010.3365.28513.stgit@neelegup-tp-t420.in.ibm.com>
References: <20140307053010.3365.28513.stgit@neelegup-tp-t420.in.ibm.com>
Date: Wed, 12 Mar 2014 10:34:12 +1100
Message-ID: <87lhwgia2z.fsf@river.au.ibm.com>
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

Neelesh Gupta <neelegup@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
> new file mode 100644
> index 0000000..cd0c135
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-async.c
> @@ -0,0 +1,203 @@
> +/*
> + * PowerNV OPAL asynchronous completion interfaces
> + *
> + * Copyright 2013 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#undef DEBUG

this strikes me as slightly odd... are you sure it's correct?
