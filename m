Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 54E2667A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 17:46:58 +1000 (EST)
Date: Thu, 21 Apr 2005 00:46:53 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Sam Song <samlinuxppc@yahoo.com.cn>
Message-ID: <20050421074653.GA8189@gate.ebshome.net>
References: <D8595042F3765A4285B848A78A2C2ED1027752@bsdmsg002.corp.satyam.ad>
	<20050421071910.46237.qmail@web15808.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050421071910.46237.qmail@web15808.mail.cnb.yahoo.com>
Cc: Atit_Shah <Atit_Shah@satyam.com>, linuxppc-embedded@ozlabs.org,
	kishorekrd@gmail.com
Subject: Re: MPC8245 custom board, Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2005 at 03:19:10PM +0800, Sam Song wrote:
> Interesting to me as well. I also have such a similar
> problem. But I wanna to know how I can return to 
> u-boot with software workaround after kernel hanging.
> At least, I must power-off and power-on my target to
> get back to u-boot console. If so, the last kernel 
> printk message would lost IMHO.

Easy, use BDI (or any other hw debugger) and reset target when it 
hangs.

-- 
Eugene
