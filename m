Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15802.mail.cnb.yahoo.com (web15802.mail.cnb.yahoo.com
	[202.165.102.82]) by ozlabs.org (Postfix) with SMTP id 11D4367B6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 19:34:39 +1000 (EST)
Message-ID: <20050706093436.80135.qmail@web15802.mail.cnb.yahoo.com>
Date: Wed, 6 Jul 2005 17:34:36 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050706051139.GB8358@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
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

Tom Rini <trini@kernel.crashing.org> wrote:
> > > [snip]
> > > Nope, that's how netconsole works, it's not
> > > interactive (like console is
> > > after init is spawned).
> > 
> > Not interactive? I meant to use netconsole to
> > repalce the mointor serial console. Meanwhile, I
> > implemented netconsole on the target in u-boot 
> > and it did get a interactive console. Maybe I can
> > try telnet after netconsole to get a net console 
> > in Linux? Sound a little bit complicated than 
> > what I thought:-)
> 
> So netconsole is a write-only kernel console. 
> Kernel messages will go out, but your init process, 
> etc will not.  For syslog type things, you
> may want to look into a syslogd that does network. 
> I don't know how netconsole support in u-boot 
> works, but it sounds like it's a network
> aware application that you can telnet into, rather
> than Linux's netconsole.

OK. I get it. The netconsole in kernel is different
from the one implemented in u-boot. The u-boot 
netconsole is a interactive console whereas kernel 
netconsole is just a simulated one after booting up.
No wawnder I need to wait 6-8 seconds to get the 
network output after loading kernel.

Thanks so much for your clarification,

Sam 


	

	
		
___________________________________________________________ 
雅虎免费G邮箱－中国第一绝无垃圾邮件骚扰超大邮箱
http://cn.mail.yahoo.com/?id=77071
