Return-Path: <lokowich@acdstar.com>
Received: from g2host.com (mailfront1.g2host.com [208.42.176.212])
	by ozlabs.org (Postfix) with ESMTP id 7C298DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Nov 2007 01:31:07 +1100 (EST)
Received: from [74.95.143.41] (account lokowich@acdstar.com HELO
	[192.168.2.105])
	by mailfront1.g2host.com (CommuniGate Pro SMTP 5.1.10)
	with ESMTPA id 24220256 for linuxppc-embedded@ozlabs.org;
	Tue, 06 Nov 2007 07:31:00 -0600
Message-ID: <47306C92.10205@acdstar.com>
Date: Tue, 06 Nov 2007 07:30:58 -0600
From: lokowich <lokowich@acdstar.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: JTAG init of MPC5200B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've been unable to properly initialize my MPC5200B from a GDB session 
or OCD Commander using a OCDemon JTAG emulator unless the device is 
first initialized by U-Boot.  I've used same register setup as defined 
in the U-Boot startup code.  This prevents me from loading a RAM-based 
U-Boot onto a bare board over the JTAG interface.  Any guidance?

-- 
Mark Lokowich
Systems Engineer
Advanced Communication Design
