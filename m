Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0356967DCA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:54:40 +1100 (EST)
In-Reply-To: <200612111525.50044.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
	<200612111525.50044.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <608642DB-3750-4EEB-BC4E-E9CF5AE1C6D2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 17:54:29 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why not this?
>
> device-type = ipmi
> compatible = ipmi-kcs

That's fine too.  Better even, the more I think about it.

> I thought the device-type tells you what kind of bindings to
> use, and the compatible (and/or model) tells you how to
> access it. E.g. all PHBs have device-type=pci and compatible=whatever,
> which tells you how to access the config space registers.

"device_type" (note the spelling -- historical accident)
shows the generic type of the device -- the programming
model for it (for OF, not for the OS necessarily!).

"model" is just the exact device type, for identification/
diagnostic purposes primarily.

"compatible" is a list of identification strings the OS
should use to find a device driver to drive this thing.


Segher
