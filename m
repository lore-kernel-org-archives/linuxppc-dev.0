Return-Path: <lravich@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5FDD42C00A4
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Nov 2013 18:53:06 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <lravich@gmail.com>) id 1Vj2at-0004zV-Sh
 for linuxppc-dev@ozlabs.org; Tue, 19 Nov 2013 23:53:03 -0800
Date: Tue, 19 Nov 2013 23:53:03 -0800 (PST)
From: ravich <lravich@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1384933983858-78251.post@n7.nabble.com>
In-Reply-To: <CAErSpo49ZLfxkEanmrrwwiqHR8koiCakqe9h8My2Mu1yA4R1Ww@mail.gmail.com>
References: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
 <CAPWoNkLTC+1ba3vwY0xiJVmmebvuXZBTwiyH5HAFfE8mRReaRQ@mail.gmail.com>
 <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
 <CAErSpo49ZLfxkEanmrrwwiqHR8koiCakqe9h8My2Mu1yA4R1Ww@mail.gmail.com>
Subject: Re: PCIE device errors after linux kernel upgrade
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

I compared the configuration hexdump of my pci controller and pci device
(FPGA) on old kernel(working 2.6.32) and new (3.8.13) and the only
difference was on the controller configuration on the memory base at Type 1
configuration header registers
.

what does it mean and could it be the trigger for my problem ?

Thanks a lot.

Leonid




--
View this message in context: http://linuxppc.10917.n7.nabble.com/Re-PCIE-device-errors-after-linux-kernel-upgrade-tp74563p78251.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
