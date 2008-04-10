Return-Path: <m8@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CEF9DE274
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:00:09 +1000 (EST)
Message-ID: <47FDEF9B.5000506@semihalf.com>
Date: Thu, 10 Apr 2008 12:44:43 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: State of the MPC5200 PSC AC97 driver
Content-Type: text/plain; charset=ISO-8859-2
Cc: spitzauer_77@gmx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sylvain,

Last year you have posted a MPC5200 PSC AC97 driver patch
"[PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface."
with the following comment:

> Not quite a clean driver, but it get things done (well, mostly).
> Only included to be able to test functionalityi/usage of
> the BestComm driver.

There are various FIXMEs and commented out code here and there.
Could you elaborate a bit on the overall state of the driver's
functionality,
which areas need improvement and attention?

Seems that you mainly tested BestComm with this driver, what was the
overall
BestComm performance, any issues here? Did you use any specific test setup
involving some dedicated application, etc.?

Did anyone else tried it and/or has a updated version or can share
experience?

Thanks in advance.

Cheers,
m.
