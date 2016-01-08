Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9A2B1A02D7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 10:10:05 +1100 (AEDT)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ED3061402BD
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2016 10:10:04 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 10 Jan 2016 18:10:01 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5938D6E803F
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jan 2016 18:09:58 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0AN9wSY30474392
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jan 2016 23:09:58 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0AN5i2Y009936
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jan 2016 18:05:45 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 1/2] powerpc: sparse: static-ify some things
In-Reply-To: <1452041151-2387-1-git-send-email-dja@axtens.net>
References: <1452041151-2387-1-git-send-email-dja@axtens.net>
Date: Fri, 08 Jan 2016 17:30:30 +1100
Message-ID: <87lh80furd.fsf@linux.vnet.ibm.com>
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

Daniel Axtens <dja@axtens.net> writes:
> As sparse suggests, these should be made static.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
