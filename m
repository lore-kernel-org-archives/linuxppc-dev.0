Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC7062C013D
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 10:40:20 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1UiDOE-0005oh-5b
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 17:40:18 -0700
Date: Thu, 30 May 2013 17:40:18 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369960818166-71847.post@n7.nabble.com>
In-Reply-To: <1369931365.14679.7@snotra>
References: <1369885321567-71775.post@n7.nabble.com>
 <1369931365.14679.7@snotra>
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

hi, scott:
  Thanks for replying!
> In what specific way does it not work?
  when I use iowrite8 to write, things seem OK, the codes continue running,
  when I use ioread8 to read, the console I use freezes. The console stops
  responding.
> Why can't it succeed?  Is there nothing mapped at 0xfc7fc000?
  My PCIe card's local bus register is at BAR0+0xC7, so the driver should
access 0xfc7fc027 and the following 7 bytes. But When I access the areas:
ioread8 just freezes. 



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71847.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
