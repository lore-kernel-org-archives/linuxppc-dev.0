Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC 3/3] zImage: Exception vector support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com> <45DB1759.2010302@am.sony.com>
	<fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 18:06:49 +0100
Message-Id: <1172250409.1902.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> If this is an ELF file, you can put the exception vectors in a
> separate segment.  Or if you don't need the entry point to
> be in the low region, (and you don't need that unless your
> boot loader ignores the entry point in the ELF header), you can
> copy the vectors in at startup and have no code linked at 0 at
> all.

No you cant. When flashed in ROM, the HV expands the bootloader binary
at 0 and jumps to 0x100

Ben.
