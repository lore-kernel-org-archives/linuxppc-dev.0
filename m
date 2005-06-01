Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 10BD8679E8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 08:58:11 +1000 (EST)
Date: Wed, 1 Jun 2005 15:58:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Message-ID: <20050601155809.A19099@cox.net>
References: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050601110836.A16559@cox.net>;
	from mporter@kernel.crashing.org on Wed, Jun 01, 2005 at
	11:08:36AM -0700
Subject: Re: [PATCH][1/3] RapidIO support: core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 01, 2005 at 11:08:36AM -0700, Matt Porter wrote:
> Adds a RapidIO subsystem to the kernel. RIO is a switched
> fabric interconnect used in higher-end embedded applications.
> The curious can look at the specs over at http://www.rapidio.org
> 
> The core code implements enumeration/discovery, management of
> devices/resources, and interfaces for RIO drivers.

I'm also hacking on a rioutils package (derived from pciutils)
that has a lsrio that works pretty much like the familiar
lspci tool.  The initial release can be grabbed from:
ftp://source.mvista.com/pub/rio/rioutils-0.10.tar.bz2

-Matt
