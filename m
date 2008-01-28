Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0623DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 02:06:58 +1100 (EST)
Date: Mon, 28 Jan 2008 09:04:22 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/9] qe/muram dts: Explicitly set address-cells and size
	cells for muram
In-Reply-To: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
Message-ID: <Pine.LNX.4.64.0801280903130.19922@blarg.am.freescale.net>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jan 2008, Paul Gortmaker wrote:

> Currently there are several dts that don't specify address or size
> cells for the muram.  This causes dtc to use default values, one of
> which is an address-cells of two, and this breaks the parsing of the
> muram ranges, which is assuming an address-cells of one. For example:
>
> Warning (reg_format): "reg" property in
> /qe@e0100000/muram@10000/data-only@0 has invalid length
> (8 bytes) (#address-cells == 2, #size-cells == 1)
>
> Explicitly setting the address and size cells gets it parsed properly
> and gets rid of the four dtc warnings.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/mpc836x_mds.dts |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>

Also fixed up mpc832x_*.dts and mpc8568mds.dts.

applied

- k
