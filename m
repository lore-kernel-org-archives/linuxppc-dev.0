Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id 52F2367A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 00:48:28 +1100 (EST)
Message-ID: <001101c5103d$7ed78470$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Vijay Padiyar" <vijay_padiyar@hotmail.com>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
References: <BAY1-DAV32181D4E594557F8931608B770@phx.gbl>
Date: Fri, 11 Feb 2005 08:27:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: problem with accessing memory mapped area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In addition, in the address range 0x30000000-0x300000FF, I have a CPLD
> mapped.
>
> Now, I wish to access the registers of this CPLD. For this, I create a
> module and insert it into the kernel. Now, in my 'init_module' function, I
> map the address range 0x30000000-0x300000FF to cpld_mem:
>
> But when I execute this program on the target, it crashes after displaying
> "Writing to CPLD". Sometimes it says 'Bus error' and some other times I
get
> a 'Kernel panic' message and the system reboots.
>

If you are getting 'bus error' it sounds like the memory controller is not
set
up [correctly] for this address.  Do you know if the bootloader is
configuring
the CPLD chip select correctly?
