Return-Path: <anton@ozlabs.org>
Date: Sun, 4 Mar 2007 10:37:51 -0600
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
Message-ID: <20070304163751.GB18888@kryten>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703041507.06307.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

> This may be a dumb question, but system would you want to run a pSeries
> kernel without PCI on? Is this just for build tests, or is there an
> actual application for this?

We have disabled it to build cut down kernels during bringup, and when
using things like mambo when you dont care about IO.

Anton
