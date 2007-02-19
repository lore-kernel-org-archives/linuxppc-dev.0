Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6C9FDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:05:43 +1100 (EST)
Subject: Re: [RFC 3/3] zImage: Exception vector support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45DA0B33.8060400@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
	<20070218014043.GD1038@crusty.rchland.ibm.com>
	<45D9BC29.5020507@am.sony.com>
	<1171914904.18571.47.camel@localhost.localdomain>
	<45DA0B33.8060400@am.sony.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 07:51:33 +1100
Message-Id: <1171918293.18571.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It won't do any good, or it won't work?  I figured it would just branch to
> _zimage_start on non-SMP systems.

Well, the SPRN_CTRLF register only exist on some processors. Also,
non-IBM processors are likely to do things differently. In fact, I'm not
even sure that all POWERx processor use the bits in there the same way.

Ben.
