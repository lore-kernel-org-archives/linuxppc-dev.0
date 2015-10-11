Return-Path: <ranshalit@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 504A11A0612
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 23:13:07 +1100 (AEDT)
Received: by igbkq10 with SMTP id kq10so60014393igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 05:13:04 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 11 Oct 2015 15:13:03 +0300
Message-ID: <CAJ2oMhLMi2PZvQoFU7JuYSsJM_UbuTsOaRfQKxqsJQq=KDG9vQ@mail.gmail.com>
Subject: use interrupt without clearing ?
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

Is it possible to register an interrupt (in linux), without using the
automatic clear of interrupt.
I need this just for testing.

Regards,
Ran
