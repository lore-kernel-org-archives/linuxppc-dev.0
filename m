Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C6FD12C0087
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2013 23:49:38 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: windfarm_fcu_controls: cpu-pump-0 <HW FAULT>
References: <87r4eb52s6.fsf@igel.home>
 <1375481448.15999.47.camel__48019.1930350431$1375481501$gmane$org@pasglop>
 <m2vc3nnp01.fsf@linux-m68k.org>
 <1375519493.15999.83.camel__49452.0221990117$1375519543$gmane$org@pasglop>
Date: Sat, 03 Aug 2013 15:49:25 +0200
In-Reply-To: <1375519493.15999.83.camel__49452.0221990117$1375519543$gmane$org@pasglop>
 (Benjamin Herrenschmidt's message of "Sat, 03 Aug 2013 18:44:53
 +1000")
Message-ID: <87r4eahoka.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Actually I see the same failure mask with the therm_pm72 driver, I
didn't notice since the driver ignores the return value from set_rpm_fan
and there is no sysfs file to monitor the cpu pumps.  So it looks like
some real hardware fault?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
