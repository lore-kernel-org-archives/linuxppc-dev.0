Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl7Xb22qvzDqZD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Mar 2017 01:49:34 +1100 (AEDT)
Received: from [192.168.1.106] (ppp-83-171-150-87.dynamic.mnet-online.de
 [83.171.150.87]) by smtp.strato.de (RZmta 40.3 DYNA|AUTH)
 with ESMTPSA id v0ab8bt2HEhM2CZ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 17 Mar 2017 15:43:22 +0100 (CET)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/pasemi, cbe: Do not process decremeter or external
 wakeup from powersave
Message-ID: <b17775f4-a2c5-ede6-33e3-6f6722a31d6e@xenosoft.de>
Date: Fri, 17 Mar 2017 15:43:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin at gmail.com> writes:

 > Hi,
 >
 > I would like to start using a dedicated stack for system reset interrupt
 > and treat it as a Linux nmi, which makes it tricky to call complex
 > interrupt handlers directly from the system reset trap handler.
 >
 > So I would like to remove the decrementer and external handler calls from
 > Cell and Pasemi platforms' system reset handler. I think we can just
 > remove them if they can be handled when they re-fire as normal 
interrupts?
 > At the moment I don't have environments set up to test if this works.


It works fine with my AmigaOne X1000. (Nemo board with a P.A. Semi  
PA6T-1682M CPU)

-- Christian
