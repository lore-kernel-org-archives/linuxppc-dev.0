Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 18412DE19D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:21:38 +1100 (EST)
Date: Wed, 14 Jan 2009 17:21:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] dts-bindings/fsl/dma.txt: fix IRQ number in mpc83xx
	dma example
Message-ID: <20090114142135.GA22862@oksana.dev.rtsoft.ru>
References: <1231942453-17898-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1231942453-17898-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Peter,

On Wed, Jan 14, 2009 at 03:14:13PM +0100, Peter Korsgaard wrote:
> The DMAC IRQ number of the mpc8349 is 71 and not 47, according to
> http://www.freescale.com/files/32bit/doc/ref_manual/MPC8349EARMAD.pdf
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> ---
>  Documentation/powerpc/dts-bindings/fsl/dma.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
> index cc45311..3df1552 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
> @@ -38,7 +38,7 @@ Example:
>  		reg = <82a8 4>;
>  		ranges = <0 8100 1a4>;
>  		interrupt-parent = <&ipic>;
> -		interrupts = <47 8>;
> +		interrupts = <71 8>;

0x47 = 71 ;-) The example is in the dts-v0 format, all the numbers
are hexadecimal.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
