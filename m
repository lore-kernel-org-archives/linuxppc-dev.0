Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8362FB6FAF
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2012 21:06:25 +1000 (EST)
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
 by gw1.transmode.se (Postfix) with ESMTP id 67A54258152
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2012 13:06:20 +0200 (CEST)
Subject: P2010 External HW IRQ number?
To: linuxppc-dev@ozlabs.org
Message-ID: <OF71CEA252.1CE143D5-ONC1257A17.00329573-C1257A17.003D00D0@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 8 Jun 2012 13:06:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I have been trying to figure out what irq number to use for external IRQs for
the P2010. There are no HW IRQ numbers in the ref manual and I cannot find
any examples in the kernel either.
How do specify irq numbers in my dts for external IRQs?
What do I use with request_irq(?,....)?

 Jocke
