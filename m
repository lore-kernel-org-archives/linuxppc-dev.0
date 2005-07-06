Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id E543967C3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 20:18:47 +1000 (EST)
To: Sam Song <samlinuxppc@yahoo.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Jul 2005 12:10:38 +0800."
	<20050706041038.70258.qmail@web15810.mail.cnb.yahoo.com>
Date: Wed, 06 Jul 2005 11:04:48 +0200
Sender: wd@denx.de
Message-Id: <20050706090448.A91BC353A6A@atlas.denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
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

In message <20050706041038.70258.qmail@web15810.mail.cnb.yahoo.com> you wrote:
>
> > Nope, that's how netconsole works, it's not
> > interactive (like console is
> > after init is spawned).
> 
> Not interactive? I meant to use netconsole to repalce
> the mointor serial console. Meanwhile, I implemented 
> netconsole on the target in u-boot and it did get a
> interactive console. Maybe I can try telnet after 

It seems you failed to read the doc/README.NetConsole fle that  comes
with  the  U-Boot sources. This explains clearly that while in U-Boot
the netconsole implementation is bidirectional, the  Linux  coede  is
unidirectional only.

> netconsole to get a net console in Linux? Sound a 
> little bit complicated than what I thought:-)

You should not use telnet for  obvious  security  problems.  Use  ssh
instead.  But  from  the technical side it is perfectly fine to use a
remote login through telnet or rsh or ssh...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
                  Nail here --X-- for new monitor.
