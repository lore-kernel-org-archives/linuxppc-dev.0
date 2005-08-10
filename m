Return-Path: <susheel.nuguru@mitron.fi>
Received: from mitron.mitron.fi (mail.mitron.fi [82.116.252.3])
	by ozlabs.org (Postfix) with ESMTP id 0AE9C68041
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 17:53:04 +1000 (EST)
From: Nuguru Susheel <susheel.nuguru@mitron.fi>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 10 Aug 2005 10:55:58 +0000
Message-Id: <1123671358.17202.13.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: sdram control register
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

 Does anyone know how to enable the bit "mode_en" in SDRAM Control
Register (MBAR + 0x0104) ... I have been struggling for that .. 

Just briefly about this register..

writing is not allowed to this register when mode_en bit = '0',

to unlock it we should write mode_en = '1', trying to do this directly
makes the core restart , i think this should be enabled VIA some command
or s0mething.. any help please ...


Thanks for the reply in Advance ..
        nSr
