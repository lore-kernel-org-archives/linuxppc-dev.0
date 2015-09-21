Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C17D1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 13:06:09 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so105235071pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 20:06:06 -0700 (PDT)
Message-ID: <1442804568.13852.9.camel@axtens.net>
Subject: Skiboot recovery of MCEs during MMIO read of SCOMs: 55672ecfa21f
From: Daniel Axtens <dja@axtens.net>
To: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 skiboot@lists.ozlabs.org
Date: Mon, 21 Sep 2015 13:02:48 +1000
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

Hi,

This relates to 55672ecfa21f ("powerpc/book3s: Recover from MC in
sapphire on SCOM read via MMIO.").

According to that patch, some SCOM reads via MMIO could lead to a
Machine Check Error in skiboot. That patch provided kernel support for a
skiboot interface to recover from those MCEs.

That patch went into the kernel in Dec 2013. However, modern skiboot
does not expose the device tree property needed to use this mechanism.
As far as I can tell, nothing ever went into Skiboot for this purpose. 

Is this something we plan to use in the future? Or is it now redundant?

-- 
Regards,
Daniel
