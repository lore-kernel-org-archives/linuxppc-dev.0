Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15804.mail.cnb.yahoo.com (web15804.mail.cnb.yahoo.com
	[202.165.102.84]) by ozlabs.org (Postfix) with SMTP id 822A367BE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 22:27:20 +1000 (EST)
Message-ID: <20050706122717.75352.qmail@web15804.mail.cnb.yahoo.com>
Date: Wed, 6 Jul 2005 20:27:17 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050706090448.A91BC353A6A@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
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

Wolfgang Denk <wd@denx.de> wrote:
[snip]
> It seems you failed to read the
> doc/README.NetConsole fle that  comes
> with  the  U-Boot sources. This explains clearly
> that while in U-Boot the netconsole implementation 
> is bidirectional, the Linux  coede  is
> unidirectional only.

Oops, I read README.NetConsole again and found the 
line in the last part. Sorry for that. I tend to 
make a mistake to do sth in the first time:-)

> > netconsole to get a net console in Linux? Sound a 
> > little bit complicated than what I thought:-)
> 
> You should not use telnet for  obvious  security 
> problems.  Use  ssh instead.  But  from  the 
> technical side it is perfectly fine to use a
> remote login through telnet or rsh or ssh...

OK, good idea to try. 

Thanks very much indeed,

Sam




	

	
		
___________________________________________________________ 
雅虎免费G邮箱－中国第一绝无垃圾邮件骚扰超大邮箱
http://cn.mail.yahoo.com/?id=77071
