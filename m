Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtwl94bxDzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 20:09:53 +1000 (AEST)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 39457440D9C_78DFA4BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 10:00:43 +0000 (GMT)
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
 [209.85.220.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 2FB8643E05D_78DFA4AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 10:00:42 +0000 (GMT)
Received: by mail-qk0-f171.google.com with SMTP id p74so10930728qka.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 03:00:42 -0700 (PDT)
MIME-Version: 1.0
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Tue, 19 Jul 2016 12:00:40 +0200
Message-ID: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
Subject: Suspected regression?
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, christophe leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I have got two boards MVME5100 (MPC7410 cpu) and MVME7100 (MPC8641D
cpu) for which I use the same cross-compiler (ppc7400).

I tested these against kernel HEAD to found that these don't boot
anymore (PID 1 crash).

Bisecting results in first offending commit:
7aef4136566b0539a1a98391181e188905e33401

Removing it from HEAD make boards boot properly again.

A third system based on P2010 isn't affected at all.

Is it a regression or I have made something wrong?

Thanks!

Ciao,
Alessio
