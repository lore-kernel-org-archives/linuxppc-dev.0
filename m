Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C8AADDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 11:18:19 +1100 (EST)
Subject: Re: [RFC/PATCH 1/2] pci: Add ability to mmap legacy_io on some
	platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200810030853.30340.jbarnes@virtuousgeek.org>
References: <20081003094951.10B3FDE183@ozlabs.org>
	<200810030853.30340.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 11:18:07 +1100
Message-Id: <1223338687.8157.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Bjorn Helgaas <bjorn.helgaas@hp.com>,
	tony.luck@intel.com, linux-pci@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-03 at 08:53 -0700, Jesse Barnes wrote:
> Tony and/or Bjorn, do you want to take a look and make sure this is ok?  If so 
> I can take the whole thing into the PCI tree.

Don't take patch 2/2, only 1/2. If/when you do, I'll then get the
powerpc side patch via the powerpc tree, as I didn't quite manage to
test it properly yet and I may want to polish a thing or two first. It's
also likely to collide with other powerpc incoming stuff, better if I
sort that out.

Cheers,
Ben.
