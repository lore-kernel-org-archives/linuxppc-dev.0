Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 04AC71A022F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 23:20:43 +1000 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 6290D1C8543
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:20:40 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
 by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ab1FY9baOhFI for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 30 Sep 2014 15:20:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BE521C853F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 15:20:40 +0200 (CEST)
Message-ID: <542AAE26.4030605@c-s.fr>
Date: Tue, 30 Sep 2014 15:20:38 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Looking for mpc8xx QMC driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: VASSEUR Patrick <patrick.vasseur@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm looking for someone having some QMC driver and/or some experience 
with the QMC (QUICC Multichannel Controlleur) on mpc8xx.
This is because we are trying to implement audio interface to codecs via 
the TDM bus using the QUICC. At the time being we are facing a major 
issue which is that after some time, we don't get any interrupts 
anymore, and we are not able to find what we did wrong.

Christophe
