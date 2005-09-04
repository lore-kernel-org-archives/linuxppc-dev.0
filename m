Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7FCA868077
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Sep 2005 10:48:26 +1000 (EST)
Message-ID: <431A42CA.5040202@gmx.net>
Date: Sun, 04 Sep 2005 02:41:46 +0200
From: evilninja <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <42FC77F7.708@g-house.de>
	<C46831A4-9BDC-4C28-9A30-55C414F4FAC4@freescale.com>
In-Reply-To: <C46831A4-9BDC-4C28-9A30-55C414F4FAC4@freescale.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: use of rtc.c on chrp/prep?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala schrieb:
> Does anyone enable CONFIG_RTC on chrp/prep?  Tom tells me these are  the
> only platforms that it is even valid to do so on.

hm, "grep CONFIG_RTC arch/ppc/configs/*" returns nothing and i don't find
this option in my .config (anymore?). CONFIG_GEN_RTC and CNFIG_GEN_RTC_X
is working fine here [1].

Christian.

[1] http://nerdbynature.de/bits/hal/2.6.13/
-- 
BOFH excuse #1:

clock speed
