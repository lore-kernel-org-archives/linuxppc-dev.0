Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:Add usb controller version info
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326865248-3333-1-git-send-email-ramneek.mehresh@freescale.com>
Date: Fri, 16 Mar 2012 10:06:56 -0500
Message-Id: <AB89D415-45D5-42A5-B145-83BFA80694DB@kernel.crashing.org>
References: <1326865248-3333-1-git-send-email-ramneek.mehresh@freescale.com>
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


On Jan 17, 2012, at 11:40 PM, Ramneek Mehresh wrote:

> Add usb controller version info for the following:
> MPC8536, P1010, P1020, P1021, P1022, P1023, P2020, P2041,
> P3041, P3060, P5020
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> ---
> Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> (branch next)
> 
> arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++--
> arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 +++
> arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    6 ++++++
> arch/powerpc/boot/dts/fsl/p1021si-post.dtsi   |    3 +++
> arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    6 ++++++
> arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   |    3 +++
> arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    3 +++
> arch/powerpc/boot/dts/fsl/p2041si-post.dtsi   |    2 ++
> arch/powerpc/boot/dts/fsl/p3041si-post.dtsi   |    2 ++
> arch/powerpc/boot/dts/fsl/p3060si-post.dtsi   |    6 ++++++
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi   |    2 ++
> 11 files changed, 38 insertions(+), 2 deletions(-)

applied

- k
