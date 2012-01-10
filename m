Return-Path: <shawn.guo@linaro.org>
Date: Tue, 10 Jan 2012 11:12:22 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
Message-ID: <20120110031220.GC23362@S2101-09.ap.freescale.net>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326134295-15547-2-git-send-email-swarren@nvidia.com>
Cc: Michal Marek <mmarek@suse.cz>, Jon Loeliger <jdl@jdl.com>,
 Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 Aurelien Jacquiot <a-jacquiot@ti.com>, microblaze-uclinux@itee.uq.edu.au,
 Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux@lists.openrisc.net,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 09, 2012 at 11:38:15AM -0700, Stephen Warren wrote:
> This hooks dtc into Kbuild's dependency system.
> 
> Thus, for example, "make dtbs" will rebuild tegra-harmony.dtb if only
> tegra20.dtsi has changed yet tegra-harmony.dts has not. The previous
> lack of this feature recently caused me to have very confusing "git
> bisect" results.
> 
> For ARM, it's obvious what to add to $(targets). I'm not familiar enough
> with other architectures to know what to add there. Powerpc appears to
> already add various .dtb files into $(targets), but the other archs may
> need something added to $(targets) to work.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Though I did not look into the patches deeply, I know the problem very
well and it annoys me a lot.  It's great that we have patches to fix
it, so

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
