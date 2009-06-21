Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89417B71E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 08:39:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCAF1DDDA2
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 08:39:28 +1000 (EST)
Subject: Re: Make bridge bug in linux 2.6.25b using Powerpc 405ep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: zhong wang <leowang1998@yahoo.com.cn>
In-Reply-To: <8647.75661.qm@web15308.mail.cnb.yahoo.com>
References: <8647.75661.qm@web15308.mail.cnb.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Jun 2009 08:39:22 +1000
Message-Id: <1245623962.16880.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-06-21 at 11:45 +0800, zhong wang wrote:
>          hello all:
>            I encountered a very strange question, I am using the AMCC
>         Powerpc 405ep its Emac0 received a single phy intel 971, Emac1
>         received RTL8305SB, they shared Mdio,  Mdc.  2.6.25.10 I use
>         the kernel.
>            The problem is to use the following command will be  eth0,
>         eth1 configured bridge .my borad will down  often. Hope that
>         helps!
> 
> 
> 

(Please use plain text emails)

When you say that your board is down, this lacks specifics about what
exactly happens. Also, do you have a HW debugger such as an abatron BDI
or a RiscWatch connected to it ? If it's hung, that would help finding
out where.

Cheers,
Ben.
> 
> ______________________________________________________________________
> 好玩贺卡等你发，邮箱贺卡全新上线！
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
