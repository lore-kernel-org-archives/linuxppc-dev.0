Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E130DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 16:16:58 +1000 (EST)
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080606161932.0650C1500054@mail96-sin.bigfish.com>
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
	<fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com>
	<20080606161932.0650C1500054@mail96-sin.bigfish.com>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 16:16:44 +1000
Message-Id: <1214893004.20711.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-06 at 09:16 -0700, Stephen Neuendorffer wrote:
> legacy_serial identifies a valid ns16550 on a simple-bus, but the
> legacy_serial driver doesn't understand the shift and offset flags
> necessary to get it to work, which results in no console.
> 
> I think the easiest solution is to change the Kconfig so that
> PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've done this
> in my tree, but I've been swamped with other things at the moment, so I
> haven't verified it.
> 
> Or is legacy_serial just legacy at this point and can go away entirely?
> I got the impression from some of the earlier discussion that it wasn't
> preferred, at least....

No, legacy serial is useful. Just grow it an understanding of the shift
& offset bits :-)

Cheers,
Ben.
