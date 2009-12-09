Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08894B82BA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 08:17:26 +1100 (EST)
Subject: Re: [PATCH 3/4] mpc8349emitx: add OF descriptions of LocalBus devices
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091116205120.GA22074@doriath.ww600.siemens.net>
Date: Wed, 9 Dec 2009 15:17:19 -0600
Message-Id: <B49F2191-6FEF-4396-ACCD-E4D864E2DD08@kernel.crashing.org>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
	<1258379934-32352-4-git-send-email-dbaryshkov@gmail.com>
	<20091116193627.GA15505@b07421-ec1.am.freescale.net>
	<20091116205120.GA22074@doriath.ww600.siemens.net>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2009, at 2:51 PM, Dmitry Eremin-Solenikov wrote:

> Describe all LocalBus chipselects on MPC8349E-MITX board. Also add flash
> bindings.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/boot/dts/mpc8349emitx.dts |   21 ++++++++++++++++++++-
> 1 files changed, 20 insertions(+), 1 deletions(-)

applied to next

- k
