Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2ED6DDE33
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 12:33:50 +1000 (EST)
Subject: Re: Trying to use Device Tree...and getting continuous interrupts
	from attached 88e1145
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
Content-Type: text/plain
Date: Sat, 04 Aug 2007 12:33:41 +1000
Message-Id: <1186194821.5733.8.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 18:54 -0400, Morrison, Tom wrote:
> Now, that looks OK! Those are what I would expect. And when the 
> mdio/phy are probed, configured, and the 88E1145 interrupt (EXT7 
> (0x37H)) is enabled, the interrupt never (seemingly) gets cleared,
> and basically hangs the entire box up and eventually it panics!
> 
> I don't even have an external phy(SFP) connected to this 88e1148 phy..
> 
> I am at a lost - is there something I am missing in device tree? 
> Help mr. wizard (Kumar?)... 

Double check you got the interrupt sense and polarity right.

Ben.
