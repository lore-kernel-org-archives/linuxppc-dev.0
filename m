Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 35A6C67B34
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:57:44 +1100 (EST)
Subject: [PATCH 0/6] AMCC 440SP/Luan board enhancements & fixes
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Message-Id: <1141256113.25761.14.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:35:13 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,

The following patches are enhancements and/or fixes for the AMCC 440SP
SoC and the Luan board.  Most notably there is support for UART2 and the
L2 Cache, as well as increased flexibility for the PCIX bridges.

--Wade Farnsworth
