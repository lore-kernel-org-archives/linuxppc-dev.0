Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.202])
	by ozlabs.org (Postfix) with ESMTP id 3C0B32BF0C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 18:37:15 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so235045rnf
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2004 23:37:07 -0800 (PST)
Message-ID: <1f729c480411242337b030152@mail.gmail.com>
Date: Thu, 25 Nov 2004 08:37:07 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org, zhonglei@rcs-9000.com
In-Reply-To: <200411251511.AA20840738@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200411251511.AA20840738@RCS-9000.COM>
Subject: Re: problem on netdevice
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> [root@198 linuxppc_2_4_devel]# tail -f /var/log/syslog
> tail: /var/log/syslog: No such file or directory
> tail: no files remaining

Depends on your system, the messages might also be directed to
/var/log/messages.

> And I found that my u-boot has detected 2 net adapters.
> But I didn't assign the 2nd one an ip address.Is it the key of the proble=
m?

No.

Either you have stored your kernel in flash in which case whatever IP
configuration the bootloader makes is useless or you have obtained
your kernel over the network; in that case your bootloader
configuration is also not relevant.

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
