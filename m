Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQXl95J59zDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 13:45:09 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3qQXl94D7mz9sC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 13:45:09 +1100 (AEDT)
Message-ID: <1458182709.23128.5.camel@neuling.org>
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 17 Mar 2016 13:45:09 +1100
In-Reply-To: <1458177720-sup-8617@x230.ozlabs.ibm.com>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1458001649.12098.59.camel@neuling.org>
 <1458177720-sup-8617@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> IMO, we should ditch the module parameter altogether and never treat
> timebase sync failure as fatal, and leave that up to any applications
> actually need it to check.

I agree with this this.

Mikey
