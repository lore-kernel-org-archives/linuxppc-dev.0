Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx:Enable USB2 controller node for P1020RDB
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326865839-3612-1-git-send-email-ramneek.mehresh@freescale.com>
Date: Wed, 18 Jan 2012 08:26:15 -0600
Message-Id: <6C99EDF2-07C6-451D-9069-E41EA7B7324F@kernel.crashing.org>
References: <1326865839-3612-1-git-send-email-ramneek.mehresh@freescale.com>
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


On Jan 17, 2012, at 11:50 PM, Ramneek Mehresh wrote:

> Enable USB2 controller node for P1020RDB. USB2 controller is used only
> when board boots from SPI or SD as it is muxed with eLBC
> 
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> ---
> Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> (branch next)
> 
> arch/powerpc/boot/dts/p1020rdb.dtsi |   11 ++++-------
> 1 files changed, 4 insertions(+), 7 deletions(-)

applied to merge

- k
