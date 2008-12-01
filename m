Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83E9FDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Dec 2008 18:54:55 +1100 (EST)
Subject: Re: Accessing PCI-E resources on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <490F6882.6050101@embedded-sol.com>
References: <490F6882.6050101@embedded-sol.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 18:54:45 +1100
Message-Id: <1228118085.7356.115.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-03 at 23:09 +0200, Felix Radensky wrote:
> Hi,
> 
> I'm currently struggling with some application
> that tries to access PCI-E memory by mmaping
> address found in /sys/bus/pci/devices/<device>/resource
> 
> mmap() fails with "invalid argument" error, apparently
> because on 460EX PCI addresses are 36-bit.
> 
> What is the correct way of accessing PCI-E from
> userspace on this platform.

I fixed a lot of these problems recently. Can you try again with
2.6.28-latest-rc ?

Cheers,
Ben.
