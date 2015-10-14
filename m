Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 691B91A072B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 06:37:39 +1100 (AEDT)
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
 by smtp.transmode.se (Postfix) with ESMTP id A86C511870AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 21:37:32 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: devicetree and IRQ7 mapping for T1042(mpic)
Date: Wed, 14 Oct 2015 19:37:32 +0000
Message-ID: <1444851451.28972.59.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am trying to figure out how to describe/map external IRQ7 in the devicetr=
ee.

Basically either IRQ7 to be left alone by Linux(becase u-boot already set i=
t up)
or map IRQ7 to sie 0(MPIC_EILR7=3D0xf0) and prio=3D0xf(MPIC_EIVPR7=3D0x4f00=
00)

There is no need for SW handler because IRQ7 will be routed to the DDR cont=
roller
and case an automatic Self Refresh just before CPU reset.

I cannot figure out how to do this. Any ideas?

If not possible from devicetree, then can one do it from board code?

 Jocke=
