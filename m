Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA2751A0EBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 20:00:16 +1100 (AEDT)
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 663F51402BB
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 20:00:16 +1100 (AEDT)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1aGjiJ-0000R7-NF
 for linuxppc-dev@ozlabs.org; Wed, 06 Jan 2016 09:45:04 +0100
Received: from static-67.218.93.111-tataidc.co.in
 ([static-67.218.93.111-tataidc.co.in])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2016 09:45:03 +0100
Received: from lucky.veeramallu by static-67.218.93.111-tataidc.co.in with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2016 09:45:03 +0100
To: linuxppc-dev@ozlabs.org
From: Lakshmi <lucky.veeramallu@gmail.com>
Subject: p4080ds IRQ vector number for he External IRQ4 and IRQ5
Date: Wed, 6 Jan 2016 08:40:59 +0000 (UTC)
Message-ID: <loom.20160106T083706-822@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have been trying to figure out what is the vector number used for external
IRQ4 and IRQ5 in P4080ds.

According to board document xpedite5470-p4080 
IRQ4: VPX GP Input 0 (GPI0)
IRQ5 VPX GP Input 1 (GPI1)

In p4080 user guide OpenPIC interrupt connection its mentioned as

IRQ4_B: SLOT4 Sideband connector (SGMII riser does not connect, XAUI riser
can use or inband)

IRQ5_B: MIC2076 USB Power FLAG for over current at USB connector

But in code i am unable to find any info related to IRQ4 and IRQ5.

How can i find??

Thanks
Lakshmi
