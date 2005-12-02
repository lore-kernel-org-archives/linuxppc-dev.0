Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 88F6168847
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 19:45:43 +1100 (EST)
Date: Fri, 2 Dec 2005 00:45:40 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Sam Song <samlinuxppc@yahoo.com.cn>
Message-ID: <20051202084540.GA16031@gate.ebshome.net>
References: <20051202062007.52513.qmail@web15804.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051202062007.52513.qmail@web15804.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Can I operate i2c device in a tasklet?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 02, 2005 at 02:20:07PM +0800, Sam Song wrote:
> Hi all,
> 
> I found that once I operated i2c bus like 
> read from i2c device in 2.4.31 kernl in a
> interrupt handler or tasklet, kernel panic
> would happen. Is there any way to make it
> in such case? I need to write sth on RTC
> alarm register with an interrupt event.
> 
> ......
> Scheduling in interrupt
> kernel BUG at sched.c:564!

You cannot access i2c layer from non-process context. Please, search 
mail list archives, this matter was discussed countless number of 
times.

-- 
Eugene
