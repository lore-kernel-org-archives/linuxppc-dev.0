MIME-Version: 1.0
Subject: SMP troubles with a 2.6.7 kernel running on a PReP machine!
Date: Wed, 21 Jul 2004 09:50:56 +0200
Message-ID: <A47F1B8E0F0CDA468B418791DBF017EA2F65D0@gwd-wininfo.top.gwdg.de>
From: "Rieger, Sebastian" <sebastian.rieger@gwdg.de>
To: <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi linuxppc-dev list!

I've got some probs running linux kernel with smp on a dual 604e PPC
(PReP arch...). Kernel runs fine without SMP - even with SMP turned on
it works for about 10-20 minutes, obviously depending on the load...
then the machine simply dead locks - I can't login anymore via network
or serial. Can you tell me some way to debug and give you a more precise
description - or even some kind of workaround? thanks in advance... BTW
using 2.4.26, SMP works fine, too...

Sebastian Rieger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
