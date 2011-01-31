Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id E7D5BB70E3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Feb 2011 07:12:32 +1100 (EST)
Message-ID: <4D4717AD.2040905@mlbassoc.com>
Date: Mon, 31 Jan 2011 13:12:29 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: MMC on MPC8379
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm running 2.6.32 on MPC8379, trying to use the SDHCI interface.
It seems to work, reads are fine, but when I write to the device
(I've tried both eMMC soldered-on and pluggable MMC/SD cards),
I get intermittent failures.  Specifically, some blocks will be
written while others fail.  I haven't yet found a pattern.

Is there anything special about this interface?  I notice that
it's not really used by any FSL platforms although the driver
claims support.

Any ideas?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
