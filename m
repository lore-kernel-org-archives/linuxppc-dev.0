Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:Add dr_mode property in USB nodes
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326869326-4271-1-git-send-email-ramneek.mehresh@freescale.com>
Date: Wed, 18 Jan 2012 08:26:08 -0600
Message-Id: <2E47922B-C25D-4117-8C90-525C85830A95@kernel.crashing.org>
References: <1326869326-4271-1-git-send-email-ramneek.mehresh@freescale.com>
To: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2012, at 12:48 AM, Ramneek Mehresh wrote:

> Add usb2 controller node for P1020RDB, P2020RDB, P2020DS, P1021MDS
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> ---
> Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> (branch next)
> 
> arch/powerpc/boot/dts/p1020rdb.dtsi |    2 ++
> arch/powerpc/boot/dts/p1021mds.dts  |    3 ++-
> arch/powerpc/boot/dts/p2020ds.dtsi  |    3 ++-
> arch/powerpc/boot/dts/p2020rdb.dts  |    3 ++-
> 4 files changed, 8 insertions(+), 3 deletions(-)

applied to merge

- k
