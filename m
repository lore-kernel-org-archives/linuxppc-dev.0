Return-Path: <heiko.schocher@invitel.hu>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 1AEAD6884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 19:02:32 +1100 (EST)
Received: from mail.invitel.hu (mail.vnet.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	C65B438807 for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 08:31:01 +0100 (CET)
Received: from embluxa7e0291e ([82.131.229.157])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0IR400BKXAALDR20@invitel.hu> for
	linuxppc-embedded@ozlabs.org; Wed, 07 Dec 2005 08:32:45 +0100 (CET)
Date: Wed, 07 Dec 2005 08:33:46 +0100
From: Heiko Schocher <heiko.schocher@invitel.hu>
To: linuxppc-embedded@ozlabs.org
Message-id: <AHEILKONAKAEJPHNMOPNEEDBCEAA.heiko.schocher@invitel.hu>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: MPC8245 with its internal UART
Reply-To: heiko.schocher@invitel.hu
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

> Who can tell me which flatform is similar to mine ? I've tried
> "make sandpoint_defconfig", but seems not the right one.

If you want to use Linux 2.4.25, you can try CPC45_defconfig
from the Denx Kernel ...

Best regards,
Heiko
