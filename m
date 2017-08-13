Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVTnh0hKnzDrGk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 16:47:32 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linuxppc-dev@lists.ozlabs.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 00/11] constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:39 +0200
Message-Id: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

---

 drivers/tty/serial/21285.c                  |    2 +-
 drivers/tty/serial/apbuart.c                |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 drivers/tty/serial/m32r_sio.c               |    2 +-
 drivers/tty/serial/meson_uart.c             |    2 +-
 drivers/tty/serial/mpc52xx_uart.c           |    2 +-
 drivers/tty/serial/mux.c                    |    2 +-
 drivers/tty/serial/owl-uart.c               |    2 +-
 drivers/tty/serial/sunsab.c                 |    2 +-
 drivers/tty/serial/sunsu.c                  |    2 +-
 drivers/tty/serial/ucc_uart.c               |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
