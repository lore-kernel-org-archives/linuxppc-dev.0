Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080310234714.GB11559@localhost.localdomain>
References: <20080310234714.GB11559@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2ad5f1b8f63afd9e32a25175d1b0b5e0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: dtc: Add some documentation for the dts formta
Date: Tue, 11 Mar 2008 19:50:11 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adds a dts-format.txt in the Documentation directory, with
> an introduction to the dtc source format.

Looks good, some minor nits...

> +* A 64-bit value is represented with two 32-bit cells.
> +
> +	e.g. clock-frequency = <0x00000001 0x00000000>;

Please add that this is big-endian order always.

> +* Values may have several comma-separated components, which are
> +  concatenated together.
> +	e.g. compatible = "ns16550", "ns8250";

You might want to clarify that the terminating 0 of ns16550 becomes
part of the property, i.e. this is not like strcat() in C.


Segher
