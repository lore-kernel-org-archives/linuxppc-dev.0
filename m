Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fZwk4CNPzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 09:07:47 +1000 (AEST)
Date: Mon, 30 Jul 2018 23:59:22 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexei Colin <acolin@isi.edu>
Cc: Alexandre Bounine <alex.bou9@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Paul Walters <jwalters@isi.edu>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Alexander Sverdlin <alexander.sverdlin@nokia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
 Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
Message-ID: <20180730225921.GE17271@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I only have this message, and patches 5 and 6.  This is meaningless
for me to review - I can't tell what you've done as far as my comments
on your previous iteration.

Please arrange to _at least_ copy all patches the appropriate mailing
lists for the set with your complete patch set if you aren't going to
copy everyone on all patches in the set.

On Mon, Jul 30, 2018 at 06:50:28PM -0400, Alexei Colin wrote:
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.

... which means, as it stands, I've no idea what you actually came up
with for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
