Return-Path: <xerofoify@gmail.com>
Received: from mail-vc0-x22a.google.com (mail-vc0-x22a.google.com
 [IPv6:2607:f8b0:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75F9D1A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 14:27:48 +1000 (EST)
Received: by mail-vc0-f170.google.com with SMTP id lf12so6340085vcb.29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:27:45 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Jul 2014 00:27:45 -0400
Message-ID: <CAPDOMVjgbC44ne=cNsj+irBv68okYgd4kzqz5xeQ7-Ka6D_9Pw@mail.gmail.com>
Subject: Fix mes in crash.c
From: Nick Krause <xerofoify@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 paul.gortmaker@windriver.com, Paul Mackerras <paulus@samba.org>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey again Ben,
I am hitting quite a few fix mes in this file. I am wondering how you
would like me to fix them.
Cheers Nick
