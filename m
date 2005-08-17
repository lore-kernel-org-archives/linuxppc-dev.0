Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id F40B267F95
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 00:00:42 +1000 (EST)
In-Reply-To: <1124209292.3869.5.camel@localhost.localdomain>
References: <1124209292.3869.5.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <76E28B16-5706-48C8-B92A-349C4F40FA76@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 09:00:46 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David's 8250 cleanup patch made me wondering when are machine checks  
suppose to recoverable?  General class of conditions is what I'm  
looking for here.

Is David's case due to some PCI master abort or something else?

- kumar

On Aug 16, 2005, at 11:21 AM, David Woodhouse wrote:

> My dual G4 PowerMac crashes sometimes when it probes for the (absent)
> serial ports. Theoretically it's supposed to take a machine check and
> recover -- but it doesn't always work like that.
