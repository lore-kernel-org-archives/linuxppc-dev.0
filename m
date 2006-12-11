Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17788.49546.390921.608302@cargo.ozlabs.ibm.com>
Date: Mon, 11 Dec 2006 13:25:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
In-Reply-To: <200612091236.57252.arnd@arndb.de>
References: <20061208114113.2191e446@localhost>
	<1165618381.1103.89.camel@localhost.localdomain>
	<F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
	<200612091236.57252.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> But the platform doesn't need how to drive them, the device driver
> needs to. All the platform needs to know is the fact that it can
> deal with SOC devices that are automatically probed.
> 
> I'd much prefer to have the list in the same file that drives the
> devices in the first place. It's probably also good to register
> them as MODULE_DEVICE_TABLE(), for documentation purposes, even
> if the driver can't be built as a module yet.

So is that an ack or a nack for the patch?  Sounds like a nack to me,
but I'm not sure. :)

Paul.
