Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 960D02C02CF
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Jun 2013 17:00:10 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UlD8B-0007yB-TJ
 for linuxppc-dev@ozlabs.org; Sat, 08 Jun 2013 00:00:07 -0700
Date: Sat, 8 Jun 2013 00:00:07 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1370674807674-72164.post@n7.nabble.com>
In-Reply-To: <1370004368473-71874.post@n7.nabble.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <1369931365.14679.7@snotra> <1369960818166-71847.post@n7.nabble.com>
 <1369994474.3928.132.camel@pasglop> <1370004368473-71874.post@n7.nabble.com>
Subject: Re: can't access PCIe card under sbc8548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi, all:
  The problem is now solved.
  In the sbc8548.dts file, the resource that is allocated to pcie controller
is not
suitable for my card. Actually, I think it is a typo, the range that is
allocated to
pcie io is 0x08000000, now I change it to 0x00800000. Then my serial card
work OK!
  Is this is a bug in sbc8548.dts?



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p72164.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
