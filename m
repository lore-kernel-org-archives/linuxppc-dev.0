Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0AEE1A0138
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 03:45:42 +1000 (AEST)
Received: by igbkq10 with SMTP id kq10so80112350igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2015 10:45:39 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Sep 2015 20:45:39 +0300
Message-ID: <CAJ2oMhLBS2BGWCfp2gfwmpdaoxtmvw2W03ffC557vhgMHw_qJw@mail.gmail.com>
Subject: floating-point
From: Ran Shalit <ranshalit@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Is floating point should be supported by default in kernel.
I see that I can't use floating point in application, although kernel
is configured with CONFIG_PPC_FPU
Does kernel required any additional configurations for floating-point?


Regards,
Ran
