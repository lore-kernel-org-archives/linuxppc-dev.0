Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 60C48686E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 18:30:40 +1100 (EST)
Message-ID: <4371A513.6040409@compulab.co.il>
Date: Wed, 09 Nov 2005 09:28:19 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Using SMC on MPC8272 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom board based on MPC8272 and I don't succeed to enable SMC 
serial port. I'm running Linux 2.6.12.3 with CPM serial drivers from 
2.6.13.2.
When I configure the kernel to use one or two SCCs, with or without 
serial console everything works fine. But if I configure the kernel to 
support SMC serial port, I see nothing at the SMC port.
I've noticed that SMC1 pins are configured at port D (as in MPC8260), 
but MPC8272 has the SMC1 on the port C. I've changed the pins assignment 
to use the port C pins, but it didn't help.
When I enable support for serial console on SCC/SMC port, the system 
hangs when the SMC is enabled.
When I don't enable support for serial console on SCC/SMC port, the 
system boots OK, but there's nothing on the SMC port.

-- 
Sincerely yours,
Mike Rapoport
