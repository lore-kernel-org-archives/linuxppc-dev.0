Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10B251A09D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 18:57:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 18 Feb 2015 17:57:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C82E22CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 18:57:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I7vgNl44630166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 18:57:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I7vG7d007120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 18:57:17 +1100
Message-ID: <54E445CC.9090304@linux.vnet.ibm.com>
Date: Wed, 18 Feb 2015 13:27:00 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 0/3] powerpc/powernv: Correctly detect optional OPAL calls
References: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2015 05:33 AM, Stewart Smith wrote:
> This series fixes three possible warnings that OPAL firmware would emit
> when booting on hardware/simulator that didn't support certain functionality.
> 
> The correct thing for Linux to do is to detect firmware capability
> by using the OPAL_CHECK_TOKEN call or examining device tree. In the case
> of these three warnings, it was OPAL_CHECK_TOKEN.

Stewart,
  Sorry.. I couldn't makeout any difference between this patchset and earlier
patchset which I had Acked except the update in cover page... (sub: Silence
"OPAL called with invalid token" errors ).

  Did I miss anything ?

-Vasant
