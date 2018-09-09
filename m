Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427KkB0dRQzDrRN
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2018 15:39:29 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id j8-v6so8876938pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Sep 2018 22:39:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Matteo Croce <mcroce@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH v2 0/3] tty: hvc: latency break regression fixes
Date: Sun,  9 Sep 2018 15:39:13 +1000
Message-Id: <20180909053916.14139-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-sending this one with the used-uinitialized warning in patch
3 fixed.

Greg these patches are needed to fix regressions in this merge
window, please consider them for your tty tree.

Thanks,
Nick

Nicholas Piggin (3):
  tty: hvc: hvc_poll() fix read loop hang
  tty: hvc: hvc_poll() fix read loop batching
  tty: hvc: hvc_write() fix break condition

 drivers/tty/hvc/hvc_console.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.18.0
