Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 5739067C75
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 05:45:34 +1000 (EST)
Date: Tue, 5 Jul 2005 12:45:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sam Song <samlinuxppc@yahoo.com.cn>
Message-ID: <20050705194532.GA6878@smtp.west.cox.net>
References: <20050705135513.94638.qmail@web15803.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050705135513.94638.qmail@web15803.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.12-rc2 netconsole problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 05, 2005 at 09:55:13PM +0800, Sam Song wrote:

[snip]
> OK, it just stoped before init process. Is there any
> necessary to fix sth on RAMDISK like add netconsole
> device node?

Nope, that's how netconsole works, it's not interactive (like console is
after init is spawned).

-- 
Tom Rini
http://gate.crashing.org/~trini/
