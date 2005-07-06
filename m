Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id E713467CBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 15:11:50 +1000 (EST)
Date: Tue, 5 Jul 2005 22:11:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sam Song <samlinuxppc@yahoo.com.cn>
Message-ID: <20050706051139.GB8358@smtp.west.cox.net>
References: <20050705194532.GA6878@smtp.west.cox.net>
	<20050706041038.70258.qmail@web15810.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050706041038.70258.qmail@web15810.mail.cnb.yahoo.com>
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

On Wed, Jul 06, 2005 at 12:10:38PM +0800, Sam Song wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> > [snip]
> > > OK, it just stoped before init process. Is there
> > > any necessary to fix sth on RAMDISK like add
> > > netconsole device node?
> > 
> > Nope, that's how netconsole works, it's not
> > interactive (like console is
> > after init is spawned).
> 
> Not interactive? I meant to use netconsole to repalce
> the mointor serial console. Meanwhile, I implemented 
> netconsole on the target in u-boot and it did get a
> interactive console. Maybe I can try telnet after 
> netconsole to get a net console in Linux? Sound a 
> little bit complicated than what I thought:-)

So netconsole is a write-only kernel console.  Kernel messages will go
out, but your init process, etc will not.  For syslog type things, you
may want to look into a syslogd that does network.  I don't know how
netconsole support in u-boot works, but it sounds like it's a network
aware application that you can telnet into, rather than Linux's
netconsole.

-- 
Tom Rini
http://gate.crashing.org/~trini/
