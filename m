Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DA36767FEE
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2005 01:12:55 +1000 (EST)
Date: Tue, 9 Aug 2005 09:52:59 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050809145259.GH7163@austin.ibm.com>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
From: Olof Johansson <olof@lixom.net>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 03:09:02PM +0200, Segher Boessenkool wrote:
> _Please_ don't throw the real device tree away; I'm happy with
> the flattened device tree if and only if it is a _minimum_
> requirement, and having a _real_ device tree (or even real
> Open Firmware support) is still an option.

We already do that. prom_init.c will walk the OF device tree and build a
flattened one before booting the kernel.


-Olof
