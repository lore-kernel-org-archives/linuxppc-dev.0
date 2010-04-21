Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1502CB7C06
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 12:15:58 +1000 (EST)
Date: Tue, 20 Apr 2010 19:16:02 -0700 (PDT)
Message-Id: <20100420.191602.228303800.davem@davemloft.net>
To: osstklei@de.ibm.com
Subject: Re: [PATCH 1/2] ehea: error handling improvement
From: David Miller <davem@davemloft.net>
In-Reply-To: <4BCC47AB.2090600@de.ibm.com>
References: <4BCC47AB.2090600@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, themann@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Klein <osstklei@de.ibm.com>
Date: Mon, 19 Apr 2010 14:08:11 +0200

> Reset a port's resources only if they're actually in an error state
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> ---
> 
> Patch created against 2.6.34-rc4

There are several problems with these patches:

1) They are corrupted by your email client, lines unchanged
   begin with one space character instead of two.  Therefore
   even 'patch' wouldn't accept these changes.

2) The double slash in the patch file paths make git not
   accept the change.  Please don't put double-slashes in
   your patch paths as that canonically means "/".

3) These are not appropriate for net-2.6 as we are deep in
   the -rcX series at this point and only the most diabolical
   bug fixes are appropriate.  Therefore, please generate these
   against net-next-2.6, thanks.
