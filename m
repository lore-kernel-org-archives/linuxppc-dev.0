Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 589C62BD6A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 16:05:06 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8H659l0015905
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 09:05:10 +0300 (EEST)
Message-ID: <414A7988.2030304@intracom.gr>
Date: Fri, 17 Sep 2004 08:43:36 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <EA78B62757AF1E4799828249310AC4CA071D280D@stca206a.bus.sc.rolm.com>
	<FE5AE866-081B-11D9-96BB-003065F9B7DC@embeddededge.com>
In-Reply-To: <FE5AE866-081B-11D9-96BB-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Sep 16, 2004, at 2:56 PM, Smith, Craig wrote:
> 
>> Can someone please tell me the current "status" of the
>> 2.6.9-rc2 kernel source
> 
> 
> It's not working for 8xx.  There are some subtle VM problems
> that I just have not had the time to track down.  A couple
> of us work on it as our time permits.  The 2.6 kernel
> works OK for 82xx and 85xx processors.  Some particular
> board ports may be missing, but the processor support
> is there along with a few board ports.
> 
>     -- Dan
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

I seem to be able ro run it OK on 8xx with an extra patch
that most people (including Dan :) ) find gross.

The biggest stumbling block are the peripheral drivers.

Use the new ethernet & serial drivers (fec_8xx & cpm_uart),
and try again.

Regards

Pantelis
