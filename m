Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 927612BD3C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 06:44:31 +1000 (EST)
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA071D280D@stca206a.bus.sc.rolm.com>
References: <EA78B62757AF1E4799828249310AC4CA071D280D@stca206a.bus.sc.rolm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FE5AE866-081B-11D9-96BB-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Sep 2004 16:07:10 -0400
To: "Smith, Craig" <craig.d.smith@siemens.com>
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


On Sep 16, 2004, at 2:56 PM, Smith, Craig wrote:

> Can someone please tell me the current "status" of the
> 2.6.9-rc2 kernel source

It's not working for 8xx.  There are some subtle VM problems
that I just have not had the time to track down.  A couple
of us work on it as our time permits.  The 2.6 kernel
works OK for 82xx and 85xx processors.  Some particular
board ports may be missing, but the processor support
is there along with a few board ports.

	-- Dan
