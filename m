Return-Path: <wolfking2000@msn.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B052E2C0090
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 22:45:31 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <wolfking2000@msn.com>) id 1Ui2EQ-00013P-5e
 for linuxppc-dev@ozlabs.org; Thu, 30 May 2013 05:45:26 -0700
Date: Thu, 30 May 2013 05:45:26 -0700 (PDT)
From: wolfking <wolfking2000@msn.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1369917926163-71826.post@n7.nabble.com>
In-Reply-To: <51A72524.2060403@windriver.com>
References: <1369885321567-71775.post@n7.nabble.com>
 <1369908140054-71817.post@n7.nabble.com> <51A72524.2060403@windriver.com>
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

tiejun.chen wrote
> On 05/30/2013 06:02 PM, wolfking wrote:
>> I tried several R/W functions: inb/outb and ioread8/iowrite8. The
>> inb/outb
> 
> What about out_be32/in_be32?
> 
> my PCIe card's internal register is only 8 bit. So I tried ioremap,
> out_8/in_8.
> It still doesn't work.
> 
> Tiejun
> _______________________________________________
> Linuxppc-dev mailing list

> Linuxppc-dev@.ozlabs

> https://lists.ozlabs.org/listinfo/linuxppc-dev





--
View this message in context: http://linuxppc.10917.n7.nabble.com/can-t-access-PCIe-card-under-sbc8548-tp71775p71826.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
