Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18069.41758.420516.135000@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jul 2007 13:42:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 1/2] Kernel: Move all technical descriptons of the Device
	Tree Complier
In-Reply-To: <1184190359.25384.129.camel@ld0161-tx32>
References: <1184190359.25384.129.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> and its formats, command lines, descriptions, etc,
> over to the Device Tree Compiler repositories now.

Hrm, section II (DT block format) is a description of a kernel
interface, and I think it should stay.  After all, there's nothing
that says that you have to use dtc to generate the device tree blob,
so there is no reason for the dtc source to be the only place where
the format is specified.

I have no problem with that section being copied over to the dtc
source.

I also don't mind section IV being removed, although a sentence saying
that dtc is useful for generating dtbs, and where to find dtc, would
be useful.

Paul.
