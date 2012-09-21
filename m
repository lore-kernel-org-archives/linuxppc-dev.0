Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB2142C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 23:17:39 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
Date: Fri, 21 Sep 2012 08:17:36 -0500
Message-Id: <89227A80-31E1-4E18-9257-6B60126E5A62@kernel.crashing.org>
References: <CAKpAL0m2XqzuYsG4-yj3WfZN88PjQXMUxFtXpx-sjsWA_Q4EUQ@mail.gmail.com>
To: Davide Viti <zinosat@tiscali.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2012, at 6:33 AM, Davide Viti wrote:

> Hi,
> I'm working on a custom board based on P1020 with two (identical) PCI =
devices attached;
> The work is derived from another board with a single instance of that =
device.
> The system is based on u-boot-2009.11 and Linux 2.6.34.6
>=20
> The "pci" command on u-boot, shows me both the PCI controllers and
> the attached devices:
>=20
> Scanning PCI devices on bus 0
> BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> _____________________________________________________________
> 00.00.00   0x1957     0x0100     Processor               0x20
>=20
> Scanning PCI devices on bus 1
> BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> _____________________________________________________________
> 01.00.00   0x1b65     0xabba     Network controller      0x80
>=20
> Scanning PCI devices on bus 2
> BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> _____________________________________________________________
> 02.00.00   0x1957     0x0100     Processor               0x20
>=20
> Scanning PCI devices on bus 3
> BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> _____________________________________________________________
> 03.00.00   0x1b65     0xabba     Network controller      0x80
>=20
> The kernel detects only the first instance of the device.

What do you mean by first instance of the device ?

> Didn't get very far while looking at dts file and kernel logs, so I'm
> asking for some help on narrowing down the problem.
>=20
> I'm wondering if I can assume that the problem is restricted to
> kernel/dts and avoid concentrating on uboot.=20
> I can provide any log (didn't want to post tons of details on the =
first=20
> message)

Probably a dts issue.

What does lspci in linux say?

- k
