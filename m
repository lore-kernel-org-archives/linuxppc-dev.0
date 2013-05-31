Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22FCB2C02A4
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 12:27:10 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UiF3d-0006Rr-1Y
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 19:27:09 -0700
Date: Thu, 30 May 2013 19:27:09 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369967229031-71850.post@n7.nabble.com>
In-Reply-To: <51A7FE17.2040803@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com> <1369899157331-71783.post@n7.nabble.com>
 <51A72D04.2090203@windriver.com> <1369918188379-71827.post@n7.nabble.com>
 <1369931094.14679.6@snotra> <51A7FE17.2040803@windriver.com>
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

hi, tiejun:
  When I don't compile my pcie card driver(in kernel or as a driver), the
kernel 
auto allocate the resoures to my pcie card, here is the output:

root@generic-powerpc-e500v2:~# cat /proc/ioports
00000000-007fffff : /pci@e0008000
  00000000-00000fff : Legacy IO
  00001000-000010ff : 0000:00:11.0
    00001000-000010ff : 8139too
feffe000-ffffdfff : /pcie@e000a000
  feffe000-ffffdfff : PCI Bus 0001:02
    fefff000-fefff0ff : 0001:02:00.0
    fefff100-fefff103 : 0001:02:00.0

the "feffe000-ffffdfff " is the resources that the kernel allocates to my
card.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71850.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
