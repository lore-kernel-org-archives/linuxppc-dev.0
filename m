Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05FDF1A0353
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 17:21:17 +1000 (EST)
Message-ID: <1403162474.4768.7.camel@concordia>
Subject: Re: Boot failure in Power7 pSeries
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Thu, 19 Jun 2014 17:21:14 +1000
In-Reply-To: <53A279FB.8010307@linux.vnet.ibm.com>
References: <53A00E2B.8030903@linux.vnet.ibm.com>
 <53A1070C.50106@linux.vnet.ibm.com> <1403078080.32307.6.camel@concordia>
 <53A155A6.2030805@linux.vnet.ibm.com> <1403141538.4768.2.camel@concordia>
 <53A2488A.1060507@linux.vnet.ibm.com> <1403150108.4768.3.camel@concordia>
 <53A279FB.8010307@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-19 at 13:49 +0800, Mike Qiu wrote:
> Hi Michael,
> 
> The config file has attached ...

Thanks.

Nothing is obviously broken in there.

Can you try building with POWERNV=n, I think that will fix it.

cheers
