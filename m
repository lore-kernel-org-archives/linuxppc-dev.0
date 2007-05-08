Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EBDE6DDE00
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 13:29:20 +1000 (EST)
Date: Mon, 7 May 2007 22:31:18 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/7] Add device tree for Ebony
Message-ID: <20070508033118.GF12613@lixom.net>
References: <20070508025832.GD11340@localhost.localdomain>
	<20070508025930.E1C1EDE0F5@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508025930.E1C1EDE0F5@ozlabs.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 12:59:30PM +1000, David Gibson wrote:
> Add a device tree for the Ebony evaluation board (440GP based).  This
> tree is not complete or finalized.  This tree needs a version of dtc
> recent enough to include reference-to-labels to process.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> ---
> 
>  arch/powerpc/boot/dts/ebony.dts |  307 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 307 insertions(+)
> 
> Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-01 15:37:24.000000000 +1000
> @@ -0,0 +1,307 @@
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "Ebony";
> +	compatible = "Ebony";

ibm,ebony? See the discussion on the Holly port.
