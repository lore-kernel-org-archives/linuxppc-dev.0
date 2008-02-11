Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4E1B4DDFB4
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 09:12:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: WARN_ON() hit in fsl bitbanged phy driver
Date: Mon, 11 Feb 2008 16:12:34 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03F9325F@ismail.innsys.innovsys.com>
In-Reply-To: <47B0C30A.1030801@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03F931E6@ismail.innsys.innovsys.com>
	<47B0C30A.1030801@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Rune Torgersen wrote:
>> I hit the following WARN_ON when using mii-tools agains a ethernet
>> interface using a bit-banged mii interface
>=20
> It looks like the kernel thinks it's in an interrupt, even though it
> clearly isn't from the backtrace.  Presumably, something
> slept from an
> interrupt handler; try turning on sleep-in-spinlock debugging.

I turned on sleep-in-spinlock and it did not reveal anything. I'm trying
some other debug options.

> The root cause was probably something other than the phy code.
I'm not so sure, because it only happens when I run mii-tool agains the
interface useing the bit-banged driver, and then only the first time.
