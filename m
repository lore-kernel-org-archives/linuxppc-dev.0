Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 8EEC1DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 23:44:58 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 19CE8F49184
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 15:25:30 +0200 (CEST)
Subject: compile warning
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Date: Fri, 26 Oct 2007 15:25:29 +0200
Message-Id: <1193405129.29250.2.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!

I have at compile time the following warning:

WARNING: vmlinux.o(.text+0x10f5c): Section mismatch: reference
to .init.text:cpm_muram_init (between 'cpm2_reset' and
'cpm2_smc_clk_setup')

Could it make some problem?

Thanks.

-- 
Sergej I. Stepanov
IDS GmbH
Nobelstr. 18, Zim. 2.1.05
D-76275 Ettlingen
T +49 (0) 72 43/2 18-615
F +49 (0) 72 43/2 18-400
http://www.ids.de
Email: Sergej.Stepanov@ids.de
