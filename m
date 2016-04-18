Return-Path: <millerjo@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpd4d2MHhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 05:09:53 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 18 Apr 2016 13:09:51 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 344F51FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 12:57:56 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IJ9l9835979314
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 12:09:47 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IJ9l2l020325
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:09:47 -0600
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, anton@samba.org
Subject: [v2] P9 ldmx support 
Date: Mon, 18 Apr 2016 14:07:59 -0500
Message-Id: <1461006482-20595-1-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Second spin of these patches:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141609.html

Differences from v1:

- As part of the FSCR context switch patch, remove extra FSCR manipulation in
  the DSCR case. If anything set FSCR.DSCR it should automatically be set
  correctly now. If I understand correctly, dscr_inherit is still required
  however and covers the < P8 case.

- Minor assembly readability clean up suggested by Segher (thanks!)

Any further comments or concerns welcome.

- Jack
