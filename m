Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 6F99667A6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 07:38:03 +1000 (EST)
Date: Tue, 5 Apr 2005 14:36:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
Message-ID: <20050405143653.A2372@cox.net>
References: <0007F077BB3476449151699150E8FEA20592AF@exchange.tsi-telsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0007F077BB3476449151699150E8FEA20592AF@exchange.tsi-telsys.com>;
	from sbajaj@tsi-telsys.com on Tue, Apr 05, 2005 at 05:21:22PM
	-0400
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI Arbiter on PPC440GX?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[This is clearly embedded stuff, redirecting to the embedded list]

On Tue, Apr 05, 2005 at 05:21:22PM -0400, Sanjay Bajaj wrote:
> How do I enable/disable PCI Arbiter on PPC440GX?

You must RTFM the PPC440GX UM in PLB-PCIX Bridge Controller chapter.
In the PCI Arbiter section, it tells you how to set CPC0_STRP1[PAE]
to enable/disable the internal PCI arbiter. They didn't even try to
hide it...

-Matt
