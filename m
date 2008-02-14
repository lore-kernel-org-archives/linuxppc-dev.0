Return-Path: <leon.woestenberg@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 2B12EDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Feb 2008 07:26:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so134325anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Feb 2008 12:26:25 -0800 (PST)
Message-ID: <c384c5ea0802141226m630fcc11h60627cde75cb8b0e@mail.gmail.com>
Date: Thu, 14 Feb 2008 21:26:25 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: High resolution timer support in 2.6.24+ for MPC831x?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

although I can enable high res timers in 2.6.24, the item note says it
does nothing if the platform does not have support for it.

My platform is a MPC8313E-RDB, and I suspect no high res clock source
implementation exists for it in 2.6.24, because
clock_getres(CLOCK_REALTIME,) gives me 1/HZ.

Is this correct and/or is anything in the works?

Regards,
-- 
Leon
