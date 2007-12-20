Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65FDDDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:56:31 +1100 (EST)
Subject: Re: patch
	pci-fix-bus-resource-assignment-on-32-bits-with-64b-resources.patch
	added to gregkh-2.6 tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gregkh@suse.de
In-Reply-To: <11981938363358@kroah.org>
References: <11981938363358@kroah.org>
Content-Type: text/plain
Date: Fri, 21 Dec 2007 10:56:13 +1100
Message-Id: <1198194973.6779.35.camel@pasglop>
Mime-Version: 1.0
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The current pci_assign_unassigned_resources() code doesn't work properly
> on 32 bits platforms with 64 bits resources. The main reason is the use
> of unsigned long in various places instead of resource_size_t.
> 
> This fixes it, along with some tricks to avoid casting to 64 bits on
> platforms that don't need it in every printk around.

Can you still edit the changelog ? If yes, please remove that sentence
since the latest version (which you put in your tree) doesn't actually
have those tricks anymore as per discussion on the list...

Sorry about that.

Cheers,
Ben.
