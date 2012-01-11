Return-Path: <msalter@redhat.com>
Subject: Re: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
From: Mark Salter <msalter@redhat.com>
To: Stephen Warren <swarren@nvidia.com>
Date: Wed, 11 Jan 2012 14:36:21 -0500
In-Reply-To: <1326134295-15547-2-git-send-email-swarren@nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Message-ID: <1326310587.2535.291.camel@deneb.redhat.com>
Mime-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, Jonas Bonn <jonas@southpole.se>,
 Jon Loeliger <jdl@jdl.com>, Russell King <linux@arm.linux.org.uk>,
 linux-c6x-dev@linux-c6x.org, Arnd Bergmann <arnd@arndb.de>,
 Aurelien Jacquiot <a-jacquiot@ti.com>, linux@openrisc.net,
 linux-kbuild@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, microblaze-uclinux@itee.uq.edu.au,
 linuxppc-dev@lists.ozlabs.org,
 Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>,
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

On Mon, 2012-01-09 at 11:38 -0700, Stephen Warren wrote:
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
> 

Acked-by: Mark Salter <msalter@redhat.com>

For the arch/c6x bit.
