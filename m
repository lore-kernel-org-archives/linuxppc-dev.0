Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id F3D1567A7E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 03:12:30 +1100 (EST)
Date: Fri, 28 Jan 2005 09:12:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050128091228.A8921@cox.net>
References: <0007F077BB3476449151699150E8FEA2059230@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA2059230@exchange.tsi-telsys.com>;
	from sbajaj@tsi-telsys.com on Fri, Jan 28, 2005 at 10:33:09AM
	-0500
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to enable TAH on PPC 440GX un lk 2.4.x?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Please fix your mailer to wrap lines properly]

On Fri, Jan 28, 2005 at 10:33:09AM -0500, Sanjay Bajaj wrote:
> Please share any information on enabling TCP/IP Acceleration Hardware
> on IBM PPC 440GX processor based board for lk 2.4.x.

You can backport the driver from 2.6 with this support.

-Matt
