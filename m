Return-Path: <jeclark2006@aim.com>
Received: from omr-d01.mx.aol.com (omr-d01.mx.aol.com [205.188.252.208])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 24F422C00AB
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jan 2014 09:16:09 +1100 (EST)
Received: from mtaout-mca02.mx.aol.com (mtaout-mca02.mx.aol.com
 [172.26.221.78])
 by omr-d01.mx.aol.com (Outbound Mail Relay) with ESMTP id 5AD05700544C1
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 17:10:23 -0500 (EST)
Received: from [10.0.0.205] (wsip-68-105-252-106.sd.sd.cox.net
 [68.105.252.106]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mtaout-mca02.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id
 0561D380000B7
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Jan 2014 17:10:22 -0500 (EST)
From: John Clark <jeclark2006@aim.com>
Content-Type: text/plain; charset=us-ascii
Subject: P1020 implementation crashes with "Data Cache Parity Error" on board
 derived from Freescale P1020Wlan eval board.
Message-Id: <E53B211E-0F37-40AA-B6E3-7539089DFD7A@aim.com>
Date: Fri, 3 Jan 2014 14:10:20 -0800
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a problem when booting the linux kernel using two cores of the =
P1020 Freescale ppc implementation.

I have found on the Freescale site one other person who has a similar =
problem and we both are using designed driver from the P1020Wlan 'eval' =
board.

I would like to know if others have this 'problem', and used the =
P1020Wlan as their hardware starting point, and what they did to =
overcome this problem.

Single core works fine. Further the original P1020Wlan board boots my =
'new' kernel, 3.10.15 from OpenWRT sources, 'just fine'.

The problem may be that we used a different DDR3 chip than the original =
eval, and some subtle difference in timing that needs some 'adjustment' =
has eluded me.

Thanks for any info/insight,

John Clark.
