Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E17A67B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 00:32:40 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k78DoLsT013051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 8 Aug 2006 15:50:21 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k78DoLu8013047
	for linuxppc-embedded@ozlabs.org; Tue, 8 Aug 2006 15:50:21 +0200 (CEST)
Date: Tue, 8 Aug 2006 15:50:20 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: PowerPC Local Bus
Message-ID: <20060808135020.GG26606@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I'm about to write drivers for some FPGA's that are connected to the
local bus of a PowerQUICC II Pro processor and use the user-programmable
machines (UPM's) to transfer data over the bus. What code does already
exist for Linux to help me with this? In the stock kernels, I can't even
find a structure definition for the registers of the local bus
controller, but it seems strange that no-one has written such code
before me. Will I really have to write everything from scratch, or what
code is there that I don't know about yet?

Cheers // Fredrik Roubert

-- 
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
