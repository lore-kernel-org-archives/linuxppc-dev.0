Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BABDC2BDA6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 02:52:15 +1000 (EST)
In-Reply-To: <41501648.6040302@intracom.gr>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<41501648.6040302@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D841A41B-0BEE-11D9-97DC-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 21 Sep 2004 12:54:04 -0400
To: Pantelis Antoniou <panto@intracom.gr>
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


On Sep 21, 2004, at 7:53 AM, Pantelis Antoniou wrote:

> BDI2000 does not work for 8xx 2.6 ATM.
>
> Dan should probably get it to work when he has time.
> At least that's what I hope...

The page table format has changed between 2.4 and 2.6.
I'm working on a solution, first to avoid any BDI firmware
changes.  If I can't do that, I'll send the info to Abatron and
ask them for an update.

Thanks.

	-- Dan
