Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 362E32BDA6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 03:01:29 +1000 (EST)
In-Reply-To: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 21 Sep 2004 13:03:29 -0400
To: "Smith, Craig" <craig.d.smith@siemens.com>
Cc: linuxppc-dev@ozlabs.org, 'Song Sam' <samlinuxppc@yahoo.com.cn>
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


On Sep 21, 2004, at 7:59 AM, Smith, Craig wrote:

> Genius. That patch appears to work for me as well.

The fact this works indicates a subtle memory management
problem elsewhere.  I don't know what that is at this
point.  This hack is in a piece of generic code that works
properly on all other PowerPC cores, so it isn't going to
ever appear in the public sources.

I suggested this change to a few people hoping the information
would lead them to finding the real problem, not that it
should be perpetuated as a "fix" to make 8xx work.
I don't personally have time to work on this right now,
so anyone using 8xx should be looking for the real
cause and solution, not using this to create products.

Thanks.


	-- Dan
