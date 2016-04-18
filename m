Return-Path: <millerjo@us.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpgkQ6H9SzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 07:09:18 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 18 Apr 2016 17:09:16 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D1BC56E8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 16:56:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IL9D8C32768244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:09:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IL9DxU028072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 17:09:13 -0400
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, anton@samba.org
Subject: [v3] P9 ldmx support
Date: Mon, 18 Apr 2016 16:08:41 -0500
Message-Id: <1461013724-12784-1-git-send-email-jack@codezen.org>
In-Reply-To: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
References: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previous spin:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141846.html

Now with 100% less 32 bit build breakage.

Mikey already called me on this one, not sure how it got back in?

- Jack
