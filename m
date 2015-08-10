Return-Path: <ranshalit@gmail.com>
Received: from mail-io0-x233.google.com (mail-io0-x233.google.com
 [IPv6:2607:f8b0:4001:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EA3E1A0935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 17:48:33 +1000 (AEST)
Received: by iodd187 with SMTP id d187so161680464iod.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 00:48:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Aug 2015 10:48:30 +0300
Message-ID: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
Subject: using general IRQs
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

MPC8349 has general IRQ numbered 0-7,
It is required to bind these IRQs with some routine , i.e. they are
not used with any specific driver.

- Should they be configured as gpios in device tree so that we can use
the gpio as irq in linux ? Is there any example ?
- After configuration, can the gpios be used in linux using the
standard /sys/class/gpio ?

Regards,
Ran
