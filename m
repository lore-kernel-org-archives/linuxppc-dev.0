Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 6F938DE112
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 07:19:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 14:19:28 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03EE4924@ismail.innsys.innovsys.com>
In-Reply-To: <20080131201601.GA10501@loki.buserror.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Does it happen without preempt?

Will try shortly, just updated my git to HEAD of Linus's tree
>=20
>> Modules linked in: drv_wd(P) drv_scc devcom drv_pcir tipc drv_ss7
>> drv_auxcpu drv_leds(P) drv_ethsw proc_sysinfo(P) i2c_8266(P)
>> NIP: c000f0a0 LR: c0011fec CTR: 00000080
>> REGS: eebe9b70 TRAP: 0300   Tainted: P         (2.6.24-test)
>=20
> Does it happen without the modules?
Cannot test without most of them.

> Do you have a simple test case that we could try to
> reproduce?  I tried a
> simple core dump on an 8280, and it worked.

I do not have a testcase, except a app for our board that does this
reliably after about 10 seconds.

> Failing that, I'd add code to the page fault handler to dump what is
> (or isn't) supposed to be mapped at the faulting address, and
> something to track which (if any) TLB miss exception it came through.

I can test code.
