Return-Path: <vvijayan@mvista.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CBC41A0272
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 20:20:19 +1000 (AEST)
Received: by iebrs15 with SMTP id rs15so17683714ieb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2015 03:20:16 -0700 (PDT)
MIME-Version: 1.0
From: Vineeth Vijayan <vvijayan@mvista.com>
Date: Mon, 6 Apr 2015 15:49:56 +0530
Message-ID: <CAOpNGcvB=Oxcd62fLzJJBuDnF2rUh3bQxWLtsT1id8m-SyDdXQ@mail.gmail.com>
Subject: Debug Enable in ppc44x_idle
To: linuxppc-dev@lists.ozlabs.org, jyoung5@us.ibm.com,
 jwboyer@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am working on a ppc440gx platform and came across ppc44x_idle()
function. the actual requirement is to enable WAIT_STATE Enable bit
(MSR_WE) and External Interrupt enable bit (MSR_EE) on MSR. But for
ppc440, i see that MSR_DE bit (Debug Interrupt Enable) is also
enabled.

Any idea why MSR_DE enabled in ppc44x_idle() function ?

Thanks
Vineeth
