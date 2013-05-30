Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 141C72C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 20:02:21 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1Uhzga-0004Uh-5g
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 03:02:20 -0700
Date: Thu, 30 May 2013 03:02:20 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369908140054-71817.post@n7.nabble.com>
In-Reply-To: <1369885321567-71775.post@n7.nabble.com>
References: <1369885321567-71775.post@n7.nabble.com>
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

I tried several R/W functions: inb/outb and ioread8/iowrite8. The inb/outb 
doesn't report any error while the ioread8 freeze. The load/storage sync 
code that I have used include mb and something else.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71817.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
