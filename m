Return-Path: <radu.rendec@gmail.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ht371RKPzF2F5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 02:36:15 +1000 (AEST)
Received: by mail-oi0-x22d.google.com with SMTP id m11-v6so10934095oic.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 09:36:15 -0700 (PDT)
MIME-Version: 1.0
From: Radu Rendec <radu.rendec@gmail.com>
Date: Fri, 3 Aug 2018 12:36:01 -0400
Message-ID: <CAD5jUk_e3LwPZGN7G3ZGHx=zdQBZSdAeoKWjxwE7Ei2=LtXQTg@mail.gmail.com>
Subject: MPC83xx reset status register (RSR, offset 0x910)
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Everyone,

Is there any kernel code that handles the "reset status register" (RSR)
on MPC83xx? I looked at arch/powerpc/platforms/83xx/misc.c, but it seems
to only map the reset register area and it's static. The watchdog driver
(drivers/watchdog/mpc8xxx_wdt.c) doesn't seem to look at it either (for
the bootstatus flags).

Basically I need to check the CPU reset reason and I thought I would ask
first, before starting to write any code of my own.

Thanks,
Radu Rendec
