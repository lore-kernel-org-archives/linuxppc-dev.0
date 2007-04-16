Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE56DDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 05:35:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3GJZEkP015680
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:35:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3GJZEII521226
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:35:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3GJYviA003588
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:34:58 -0400
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1176644012.5422.3.camel@concordia.ozlabs.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
	<1176491513.28514.66.camel@farscape.rchland.ibm.com>
	<1176644012.5422.3.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 16 Apr 2007 14:34:31 -0500
Message-Id: <1176752071.28514.100.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-15-04 at 23:33 +1000, Michael Ellerman wrote:
> On Fri, 2007-04-13 at 14:11 -0500, Will Schmidt wrote:
> > On Fri, 2007-13-04 at 17:47 +1000, Michael Ellerman wrote:
> > 
> > Is this part temporary for your graphing, or think it's something that
> > should go in? 
> 
> No that's just debug foobar I used for the graphs, I'll send a cleaned
> up version during the week if you don't beat me to it.

I'll do it, just waiting to see if I should rework it to include a sys
interface or not..

> Time to get a blag! ;)

yup. 

> cheers
> 
-Will
