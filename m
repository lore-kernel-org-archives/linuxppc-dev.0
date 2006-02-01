Return-Path: <jacmet@sunsite.dk>
Received: from hoboe2bl1.telenet-ops.be (hoboe2bl1.telenet-ops.be
	[195.130.137.73]) by ozlabs.org (Postfix) with ESMTP id F3224689FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 08:12:44 +1100 (EST)
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu> <20060201104405.C16064@cox.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 01 Feb 2006 22:14:15 +0100
In-Reply-To: <20060201104405.C16064@cox.net> (Matt Porter's message of "Wed,
	1 Feb 2006 10:44:05 -0700")
Message-ID: <87wtgeeq8o.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jenkins, Clive" <Clive.Jenkins@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Matt" == Matt Porter <mporter@kernel.crashing.org> writes:

 Matt> read*/write* and ioread*/iowrite* generate outbound little
 Matt> endian cycles on ALL arches, period.  They are intended
 Matt> only for PCI use and have generic names only because of
 Matt> the assumption that "all the world is a PC".

What is the preferred way of accessing non-PCI devices then? Direct
pointer access?

-- 
Bye, Peter Korsgaard
