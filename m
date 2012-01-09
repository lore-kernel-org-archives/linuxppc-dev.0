Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFD0FB6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 06:42:15 +1100 (EST)
Message-Id: <E1RkKQN-0000nM-2c@jdl.com>
To: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] dtc: Implement -d option to write out a dependency
 file
In-reply-to: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
Date: Mon, 09 Jan 2012 12:58:27 -0600
From: Jon Loeliger <jdl@jdl.com>
Cc: Michal Marek <mmarek@suse.cz>, Jonas Bonn <jonas@southpole.se>,
 Michal Simek <monstr@monstr.eu>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, Arnd Bergmann <arnd@arndb.de>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Paul Mackerras <paulus@samba.org>,
 Mark Salter <msalter@redhat.com>, microblaze-uclinux@itee.uq.edu.au,
 linuxppc-dev@lists.ozlabs.org, linux@lists.openrisc.net,
 linux-arm-kernel@lists.infradead.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This will allow callers to rebuild .dtb files when any of the /include/d
> .dtsi files are modified, not just the top-level .dts file.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is against the Linux kernel's copy of dtc, but it applies to
> upstream dtc with a couple of trivial conflicts. I can post a version for
> upstream dtc as well if desired.

If it does go upstream into Linux proper, we should
definitely have it in the main DTC repository.
So if you would, please send me a path that applies there.

Thanks,
jdl
