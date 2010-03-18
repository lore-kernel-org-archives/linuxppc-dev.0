Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B62CB7B98
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 19:58:28 +1100 (EST)
Subject: Re: how can I write a Device Tree Source for PCI-PCI Bridge?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jianbin Hu <ntrees.hu@gmail.com>
In-Reply-To: <72714651003171005i5b7d7f7ai25e6b9876deb3d4@mail.gmail.com>
References: <72714651003171005i5b7d7f7ai25e6b9876deb3d4@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 19:58:19 +1100
Message-ID: <1268902699.2335.234.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-03-18 at 01:05 +0800, Jianbin Hu wrote:
> My board have a PCIe switch(PLX PEX8608), which have a AMCC 460EX
> processor. I have parted the dts source file from canyonlands.dts. But
> I have no idea for the PCI bridge device node. Is anyone have a
> suggestion ? 

Hi !

First, you don't always need one. The kernel will be happy without a
device node, unless you want to also represent some devices below that
bridge for some reason (such as providing the driver with specific
properties from the FW), or your interrupt routing for devices below the
bridge doesn't follow the standard PCI swizzling.

If you really want to represent it, let me know, I'll try to cook up an
example for you tomorrow. You may want to read the Open Firmware PCI
binding too which contains all the explanation but it can be a tedious
read :-)

Cheers,
Ben.
