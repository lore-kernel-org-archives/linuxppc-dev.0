Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 997EEDDEEE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 16:57:45 +1000 (EST)
Subject: Re: [viro@ftp.linux.org.uk: [PATCH] rpadlpar breakage - fallout of
	struct subsystem removal]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1179276588.4120.22.camel@concordia.ozlabs.ibm.com>
References: <20070515194729.GE4095@ftp.linux.org.uk>
	<1179276588.4120.22.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 16 May 2007 16:57:09 +1000
Message-Id: <1179298629.32247.214.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> That seems to work, I get 'add_slot' and 'remove_slot'
> under /sys/bus/pci/slots/control again.

I verified that PCI hotplug actually works with that patch.

Ben.
