Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id A28651A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 22:02:09 +1000 (AEST)
Message-ID: <5572D773.1090008@c-s.fr>
Date: Sat, 06 Jun 2015 13:20:19 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, Rob Herring <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Subject: [BUG] mpc8323_rdb platform doesn't boot since kernel 3.16
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got a MPC8323 RDB evaluation platform from freescale
kernel 4.0 doesn't boot
kernel 3.16 doesn't boot
kernel 3.15 boots ok

I disected the issue down to your commit "of/fdt: Convert FDT functions 
to use libfdt" (e6a6928c3ea1d0195ed75a091e345696b916c09b)

Do you have an idea of what the issue could be ?

Christophe

---
L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=C3=
=A9rifi=C3=A9e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
