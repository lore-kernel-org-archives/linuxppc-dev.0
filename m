Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3957ADE01F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:20:40 +1000 (EST)
Message-ID: <4832FA80.7060807@freescale.com>
Date: Tue, 20 May 2008 11:21:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops in fs_enet driver with preempt-rt
References: <DCEAAC0833DD314AB0B58112AD99B93B046E728C@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
	<4832F139.1020502@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E73C6@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E73C6@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Hmm.... ttyCPM1 output seems to be kinda garbled... Any ideas?
> Incomplete locking between printk and userland use of ttyCPM1 as
> console?

s/incomplete/nonexistent/ :-P

Try acquiring port->lock in cpm_uart_console_write.

-Scott
