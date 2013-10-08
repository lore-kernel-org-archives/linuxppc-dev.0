Return-Path: <ivan.mercier@gmail.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com
 [IPv6:2a00:1450:4010:c04::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E74D2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 01:07:36 +1100 (EST)
Received: by mail-lb0-f174.google.com with SMTP id w6so6816193lbh.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Oct 2013 07:07:31 -0700 (PDT)
MIME-Version: 1.0
From: Mercier Ivan <ivan.mercier@gmail.com>
Date: Tue, 8 Oct 2013 16:06:51 +0200
Message-ID: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
Subject: Elbc device driver
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm working on a powerpc qoriq p3041 and trying to communicate with a
device by elbc bus in gpmc mode.

I 've integrated CONFIG_FSL_LBC in Linux which provide the basic functions.

Now I'm wondering how can I do read and write operations on the
bus.Where is mapped my device?

Should I code .read and .write driver functions?How can I start?

How integrates my device in the device tree?



thanks a lot,

Ivan
