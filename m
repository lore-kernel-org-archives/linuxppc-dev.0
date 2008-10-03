Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D755DDE28
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 07:52:11 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] powerpc: Add legacy PCI access via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200810030859.12335.jbarnes@virtuousgeek.org>
References: <20081003094953.A7F4EDE184@ozlabs.org>
	<200810030859.12335.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Sat, 04 Oct 2008 07:52:03 +1000
Message-Id: <1223070723.12264.213.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-pci@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 08:59 -0700, Jesse Barnes wrote:
> 
> Feel free to change the generic code if it makes things easier for you, the 
> only limitation is that we have to live within the generic sysfs read/write 
> functions.  Obviously I didn't worry about it when doing this code on ia64...

I started to do that and then decided not to bother...

Ben.
