Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7A11D683D4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Sep 2005 02:57:18 +1000 (EST)
Date: Thu, 29 Sep 2005 09:57:15 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sam Song <samlinuxppc@yahoo.com.cn>
Message-ID: <20050929165715.GA24176@gate.ebshome.net>
References: <20050929123535.66570.qmail@web15803.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050929123535.66570.qmail@web15803.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Available user-level tool for I2C device?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2005 at 08:35:35PM +0800, Sam Song wrote:
> I have a RTC chip DS1337 on a 8248 target. It can
> work right in u-boot and linux. If no similar utility,
> I will switch to change hwclock.c in busybox to make
> it. Any idea?

Right approach would be making standard in-kernel RTC driver for this 
chip. In fact, such driver was already posted to lm-sensors list some 
time ago.

-- 
Eugene
