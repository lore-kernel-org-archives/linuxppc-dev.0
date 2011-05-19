Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/p1022ds: fix broken mpic timer node
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110324214352.GA9524@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:01:32 -0500
Message-Id: <A207424B-6F6F-4ECA-907A-68BFD7793700@kernel.crashing.org>
References: <20110324214352.GA9524@schlenkerla.am.freescale.net>
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

> There is no hardware interrupt 0xf7.  But now we can express the timer
> interrupt using 4-cell interrupts.  This requires converting all of =
the
> other interrupt specifiers in the tree as well.
>=20
> Also add the second timer group, and fix the reg property to only
> describe the timer registers.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |  106 =
++++++++++++++++++++----------------
> 1 files changed, 59 insertions(+), 47 deletions(-)

applied to next

- k=
