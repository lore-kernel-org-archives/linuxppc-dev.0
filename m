Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32248DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:56:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lASJu1e9005117
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 12:56:01 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lASJu0GM018790
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 13:56:00 -0600 (CST)
Message-ID: <474DC7D0.4080907@freescale.com>
Date: Wed, 28 Nov 2007 13:56:00 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Why are CONFIG_LOCKDEP_SUPPORT, CONFIG_TRACE_IRQFLAGS_SUPPORT, and
	CONFIG_STACKTRACE_SUPPORT not defined for PowerPC?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These three Kconfig options:

	CONFIG_LOCKDEP_SUPPORT
	CONFIG_TRACE_IRQFLAGS_SUPPORT
	CONFIG_STACKTRACE_SUPPORT

Are not defined for ppc or powerpc, but they are defined for several other 
architectures.  I'm trying to debug some semaphore locks in ALSA, and these 
defines are necessary to enable some other Kconfig features.

-- 
Timur Tabi
Linux kernel developer at Freescale
