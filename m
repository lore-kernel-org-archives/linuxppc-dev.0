Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 60329DDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:30:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Oops in fs_enet driver with preempt-rt
Date: Tue, 20 May 2008 11:31:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E73EC@ismail.innsys.innovsys.com>
In-Reply-To: <4832FA80.7060807@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B046E728C@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
	<4832F139.1020502@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E73C6@ismail.innsys.innovsys.com>
	<4832FA80.7060807@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
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

Scott Wood wrote:
> Rune Torgersen wrote:
>> Hmm.... ttyCPM1 output seems to be kinda garbled... Any ideas?
>> Incomplete locking between printk and userland use of ttyCPM1 as
>> console?
>=20
> s/incomplete/nonexistent/ :-P
>=20
> Try acquiring port->lock in cpm_uart_console_write.
>=20
> -Scott

That worked. Console output is sane again.
