Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF43D2BC0F
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2004 13:15:08 +1000 (EST)
In-Reply-To: <20041015154946.GB3957@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20041015154946.GB3957@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38677C16-20B3-11D9-AC5A-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 17 Oct 2004 23:10:10 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-dev@ozlabs.org, 'Song Sam' <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2004, at 11:49 AM, Marcelo Tosatti wrote:

> Do you know the real cause Dan ?

The symptom is we appear to have a stale TLB entry,
so at least one of the callouts from the generic VM
code isn't doing the right thing for us.  I'm still
puzzled as to why it doesn't affect other PPC processor.

> As I told you, we are porting our sub-sub-architecture
> to v2.6, and need that bug fixed at some time.

I don't have any incentive to work on 8xx for 2.6 right
now.  When I have a little free time I try to work on it,
but I have other things placing demands on my
time right now.

Thanks.


	-- Dan
