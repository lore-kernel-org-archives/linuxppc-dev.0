Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 27 May 2011 14:29:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/4] Consolidate sdhci pltfm & OF drivers and get them
	self registered
Message-ID: <20110527202906.GF6645@ponder.secretlab.ca>
References: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
	<20110527072647.GE31953@ponder.secretlab.ca>
	<m3pqn4ruv9.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3pqn4ruv9.fsf@pullcord.laptop.org>
Cc: sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	Saeed Bishara <saeed@marvell.com>,
	Xiaobo Xie <X.Xie@freescale.com>, kernel@pengutronix.de,
	Mike Rapoport <mike@compulab.co.il>, Olof Johansson <olof@lixom.net>,
	Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2011 at 12:06:18PM -0400, Chris Ball wrote:
> Hi Grant,
> 
> On Fri, May 27 2011, Grant Likely wrote:
> > Any chance we can get this series into $NEXT_KERNEL?
> 
> I think I'd rather not in this case, hope that's okay.  It hasn't seen
> testing in linux-next yet, there's a reasonable chance of it breaking
> sdhci-pltfm users in subtle ways -- we haven't had much testing from
> the individual -pltfm driver maintainers yet -- and the mmc merge was
> (relatively) huge already this cycle.
> 
> I'll certainly push it to linux-next as soon as -rc1 is released,
> though.  Sound okay?

okay.

g.
