Return-Path: <lravich@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F40EF2C0266
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Aug 2013 21:50:49 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <lravich@gmail.com>) id 1VB1CC-0003LO-6V
 for linuxppc-dev@ozlabs.org; Sun, 18 Aug 2013 04:30:56 -0700
Date: Sun, 18 Aug 2013 04:30:56 -0700 (PDT)
From: ravich <lravich@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1376825456181-75193.post@n7.nabble.com>
In-Reply-To: <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
References: <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
 <CAPWoNkLTC+1ba3vwY0xiJVmmebvuXZBTwiyH5HAFfE8mRReaRQ@mail.gmail.com>
 <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
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

Hi

>>Is this still a problem, or have you found a solution in the meantime? 
I did not found any solution yet
>>Where are the "PCIE ERR_CAP_STAT" and similar messages from? 
PCIE ERR_CAP_STAT is coming from:
drivers/edac/mpc85xx_edac.c

>>Can you post the complete logs somewhere, maybe in a bugzilla or similar? 
cant I post here??

Thanks for your time 



--
View this message in context: http://linuxppc.10917.n7.nabble.com/Re-PCIE-device-errors-after-linux-kernel-upgrade-tp74563p75193.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
