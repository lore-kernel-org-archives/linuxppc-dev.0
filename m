Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc/mpic: add the mpic global timer support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110324214355.GC9524@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:01:49 -0500
Message-Id: <A8328BF9-349B-4CC4-B9FF-C98DEA2CD74B@kernel.crashing.org>
References: <20110324214355.GC9524@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 24, 2011, at 4:43 PM, Scott Wood wrote:

> Add support for MPIC timers as requestable interrupt sources.
>=20
> Based on http://patchwork.ozlabs.org/patch/20941/ by Dave Liu.
>=20
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/mpic.h |    3 +-
> arch/powerpc/sysdev/mpic.c      |   92 =
++++++++++++++++++++++++++++++++++++---
> 2 files changed, 88 insertions(+), 7 deletions(-)

applied to next, fixed for upstream changes.

- k=
