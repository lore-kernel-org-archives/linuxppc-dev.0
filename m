Return-Path: <johnstul@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C3A667BD0
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 03:56:38 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BHuZfi029105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:56:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BHuQPi145536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:56:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BHuQ7k013504
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:56:26 -0600
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: john stultz <johnstul@us.ibm.com>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
In-Reply-To: <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	<17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	<yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 10:56:23 -0700
Message-Id: <1155318983.5337.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-11 at 15:08 +0900, Tsutomu OWA wrote:
> > On Fri, 11 Aug 2006 15:11:47 +1000
> > Paul Mackerras <paulus@samba.org> said:
> 
> > I would be very surprised if this is all that is required for
> > CONFIG_GENERIC_TIME to work correctly on powerpc.  Have you verified
> > that the CONFIG_GENERIC_TIME stuff works correctly on powerpc and
> > provides all the features provided by the current implementation?
> 
>   Well, probably no as you say so.
> 
>   What I did for CONFIG_GENERIC_TIME is just to fix a compile
> error and to see if the kernel boots or not.  As I mentioned,
> it's experimental and is posted to see whether I'm moving in the
> right direction or not.
> 
>   I'm afraid I have not yet looked into any generic time related 
> features/implementations.  Looks like generic time related things
> should be on the ToDo list.

You might take a peek at the patch set here:
http://sr71.net/~jstultz/tod/ for a somewhat rough powerpc conversion to
CONFIG_GENERIC_TIME.

thanks
-john
