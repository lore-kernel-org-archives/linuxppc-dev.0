Return-Path: <shiva@sewingwitch.com>
Received: from segw2.mpa.lan (segw2.microprecisionautomation.com
	[69.17.55.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E17EDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 11:40:16 +1100 (EST)
Received: from home.sewingwitch.com (c-69-181-148-112.hsd1.ca.comcast.net
	[69.181.148.112]) (authenticated bits=0)
	by segw2.mpa.lan (8.13.8/8.13.8) with ESMTP id lAK0KOEm009799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Nov 2007 16:20:30 -0800
Received: from [10.0.0.14] ([10.0.0.14]) (authenticated bits=0)
	by home.sewingwitch.com (8.13.1/8.13.1) with ESMTP id lAK0KLGj017201
	for <linuxppc-embedded@ozlabs.org>; Mon, 19 Nov 2007 16:20:31 -0800
Date: Mon, 19 Nov 2007 16:20:21 -0800
From: Kenneth Porter <shiva@sewingwitch.com>
To: linuxppc-embedded@ozlabs.org
Subject: Looking for small form factor with HDLC
Message-ID: <CDD877E4B771FEED28BF8BF5@[10.170.7.6]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm attempting to create a middleware system that talks to one of my 
vendor's motion control products. My vendor has an FPGA capable of perhaps 
10 megabit performance, and RS485 full-duplex tranceivers. I want to be 
able to send commands and receive events and bulk data efficiently. I'll 
also add electrical isolation, possibly with suitable 485 transceivers.

I'm thinking that HDLC is a natural fit for the bit-level protocol, so I'm 
looking for an SBC and Linux OS with natural HDLC support. Ideally the SBC 
would fit in a 3"x3"x1" volume, and include Ethernet. It will go on a 
backplane along with the motion control box.

The Freescale chips look like many have the hardware to do HDLC, so I'm 
wondering what's available for boards and drivers.
