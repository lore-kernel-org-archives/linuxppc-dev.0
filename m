Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id E212B67A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 06:03:34 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j1MJ3WmZ011285 for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 14:03:32 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id OAA03084
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 14:03:32 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64766A@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 22 Feb 2005 14:03:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE:  PPC32 8xx MPC880  Linux 2.6 Interrupt storm 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

- I forgot to mention in my post that i2c-algo-8xx.c and i2c-algo-8xx.h,
which I am using, were "taken" from Linux 2.4.26 ...
until some time ago, even bulding of 8xx with I2C configured was broken.
I copied i2c-algo-8xx.h from Linux 2.4.26
 into 2.6.10-rc3 code source and made couple small changes
to allow building of the 8xx code with I2C configured, please see: 
http://archives.andrew.net.au/lm-sensors/msg28725.html
 
Could there be some incompatibility between the way how i2c-algo-8xx.c 
("taken" from Linux 2.4.26 )
 handles interrupt vs how it is "expected to be " by Linux 2.6 ?
