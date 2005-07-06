Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15810.mail.cnb.yahoo.com (web15810.mail.cnb.yahoo.com
	[202.165.102.90]) by ozlabs.org (Postfix) with SMTP id B0DFB67C8E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 14:10:42 +1000 (EST)
Message-ID: <20050706041038.70258.qmail@web15810.mail.cnb.yahoo.com>
Date: Wed, 6 Jul 2005 12:10:38 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050705194532.GA6878@smtp.west.cox.net>
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
> [snip]
> > OK, it just stoped before init process. Is there
> > any necessary to fix sth on RAMDISK like add
> > netconsole device node?
> 
> Nope, that's how netconsole works, it's not
> interactive (like console is
> after init is spawned).

Not interactive? I meant to use netconsole to repalce
the mointor serial console. Meanwhile, I implemented 
netconsole on the target in u-boot and it did get a
interactive console. Maybe I can try telnet after 
netconsole to get a net console in Linux? Sound a 
little bit complicated than what I thought:-)

Uh, is this the real reason that netconsole in Linux
_must_ disable ethernet interrupt whereas network 
does need it?

Thanks a lot,

Sam


		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠No.1µƒ∑¿∂æ∑¿¿¨ª¯≥¨¥Û” œ‰ 
http://cn.mail.yahoo.com/?id=77072
