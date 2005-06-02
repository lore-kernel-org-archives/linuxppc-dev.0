Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 41A92679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 09:50:32 +1000 (EST)
Date: Wed, 1 Jun 2005 17:00:50 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050602000050.GA5678@kroah.com>
References: <20050601110836.A16559@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050601110836.A16559@cox.net>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
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
> 
> There's a lot more to do to take advantages of all the hardware
> features. However, this should provide a good base for folks
> with RIO hardware to start contributing.
> 
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> 
> Patch is 108KB and can be found here:
> ftp://source.mvista.com/pub/rio/l26_rio_core.patch

Care to split it up into logical sections and post it?  It should be
small enough to do so that way.

thanks,

greg k-h
