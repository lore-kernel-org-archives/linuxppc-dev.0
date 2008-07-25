Return-Path: <miltonm@sullivan.realtime.net>
Date: Thu, 24 Jul 2008 20:08:41 -0500 (CDT)
Message-Id: <200807250108.m6P18f4B099179@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <1216887460.306306.238738123378.1.gpush@pingu>
References: <1216887460.306306.238738123378.1.gpush@pingu>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Currently, tarball builds for powerpc kernels don't have any boot
> images (other than vmlinux) present.
> 
> Add support for powerpc builds in the buildtar script, to include
> a few default images.
> 
> Signed-off-by: Jeremy Kerr <jk at ozlabs.org>
> 
> ---
> RFC: any requests for more/less boot images?
> 
..
> +		for img in zImage zImage.pseries zImage.iseries \
> +				dtbImage dtbImage.ps3

Yes.  How about all dtbImage, zImage, cuboot, treeboot, etc
that are newer than vmlinux?


milton
