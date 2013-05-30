Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 596602C007A
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 19:15:43 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UhyxR-00047x-2p
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 02:15:41 -0700
Date: Thu, 30 May 2013 02:15:41 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369905341079-71815.post@n7.nabble.com>
In-Reply-To: <51A71225.2040102@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com> <1369898369690-71782.post@n7.nabble.com>
 <51A71225.2040102@windriver.com>
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

hi, tiejun.chen:
  When I use ioremap, the card seems to work fine. That is, I can access
part of all register. My PCIe card is a rs232 expand card, it has some
standard UART register, for example the SCR(scratch register). My driver 
can access the SCR(write and read) normally, but the other registers
behave odd. For example, the DLM should be 0, but it reads 5. The card
has a software reset bit, when it is set to 1, the card reset itself. When
it finished reset, this reset bit should be back to 0. But In sbc8548, when
I set this
bit, it remains high. So I guess, the area I accessed is not the PCIe card,
instead it maybe some RAM in the system. :>
I'm sure the card hardware is OK, I insert it into the 8641d board, it works
ok.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71815.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
