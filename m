Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A652C67A6E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 02:21:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j35GO1Ux010332
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2005 09:24:01 -0700 (MST)
Received: from [10.82.244.138] ([10.82.244.138])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j35GNuZ6006823
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2005 11:23:56 -0500 (CDT)
Mime-Version: 1.0 (Apple Message framework v619.2)
Message-Id: <17e04050dd77805d8dd464fd6a1af284@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 5 Apr 2005 11:21:52 -0500
Subject: Perfmon feature
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm adding oprofile support for 7450 (and derivative) processors, and 
I'm considering adding a couple PPC_FEATURE bits (one for classic, and 
one for fsl-book-e perfmon).

Reasons:
1) The need to distinguish between Freescale Book-E processors with 
performance monitor support, Classic PPC processors with perfmon 
support, and processors without perfmon support.  (ie - 7450 parts will 
have support, but 7410 parts will not for now).

2) Applications could determine if these features were present, and 
decide between using mfspr and mfpmr instructions to read the counters 
from user-space.

Thoughts, objections?


Andy Fleming
Open Source Team
Freescale Semiconductor, Inc
