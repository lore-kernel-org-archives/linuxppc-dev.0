Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69D1F100823
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:23:52 +1000 (EST)
Subject: Re: [PATCH v2 1/2] DTS: Change deprecated binding for 85xx-based
	boards
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTinaSEyVowG4103g5q-FmFMMMHuXJUeCV2oiSu5-@mail.gmail.com>
Date: Wed, 4 Aug 2010 14:23:47 -0500
Message-Id: <02966D66-93E9-466D-872C-C6AFD9997EA4@kernel.crashing.org>
References: <AANLkTinaSEyVowG4103g5q-FmFMMMHuXJUeCV2oiSu5-@mail.gmail.com>
To: Bradley Hughes <bhughes@silicontkx.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2010, at 5:04 PM, Bradley Hughes wrote:

> The "fsl,85..." style compatible binding was to be deprecated
> some time ago.  This patch corrects existing occurrences of
> the incorrect binding.  The memory-controller and
> l2-cache-controller are the only affected nodes.
> 
> Signed-off-by: Bradley Hughes <bhughes@silicontkx.com>
> ---
> arch/powerpc/boot/dts/mpc8540ads.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8541cds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8544ds.dts  |    4 ++--
> arch/powerpc/boot/dts/mpc8548cds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8555cds.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8560ads.dts |    4 ++--
> arch/powerpc/boot/dts/mpc8568mds.dts |    4 ++--
> 7 files changed, 14 insertions(+), 14 deletions(-)

applied to next

- k
