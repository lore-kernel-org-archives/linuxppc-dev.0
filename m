Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5383EDDE3A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 17:32:29 +1000 (EST)
Subject: Re: SPI devices and OF
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5199678E-7A42-4B91-BBB8-81DF33E92F2A@kernel.crashing.org>
References: <20070404110916.GA9910@localhost.localdomain>
	<acd2a5930704040451u55ae7619wfa1aaa84aebdf72@mail.gmail.com>
	<4850DC60-A560-4A38-8416-ADA776B69509@kernel.crashing.org>
	<200704041903.46629.arnd@arndb.de>
	<5199678E-7A42-4B91-BBB8-81DF33E92F2A@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 17:32:18 +1000
Message-Id: <1175758338.30879.123.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  From explicitly board code like we do today.  I mean the mechanism  
> can very so greatly that trying to decided and come up with all  
> possible cases and somehow encoding that in the device tree isn't  
> worth the effort.  Additionally you'll still need code to handle the  
> actual chip select and I don't see how you make that generic at all.
> 
> A board designer could use I2C, GPIO, or something off an FPGA.  I  
> just dont see trying to 'encode' this in the device tree as providing  
> any real value.

Or board designers can use board specific device-tree bits and board
specific code to udnerstand them :-) That works too and can be handy if
you have for example several versions of a board with small differences
that you want to expose that way in the device-tree.

That is, the devive-tree -can- be used to put proprietary stuff, though
if you do so, you should try to use prefixes on your properties, like
mycompany,xxxx

Ben.
