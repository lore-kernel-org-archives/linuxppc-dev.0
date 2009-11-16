Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47DE3B7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 06:36:32 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAGJaSLV012277
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 12:36:29 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nAGJegGG003437
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 13:40:42 -0600 (CST)
Date: Mon, 16 Nov 2009 13:36:27 -0600
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/4] mpc8349emitx: add OF descriptions of LocalBus devices
Message-ID: <20091116193627.GA15505@b07421-ec1.am.freescale.net>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
	<1258379934-32352-4-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258379934-32352-4-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 04:58:53PM +0300, Dmitry Eremin-Solenikov wrote:
> +		flash@0,1 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0x0 0x800000 0x800000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +		};

Should be "flash@0,800000".

-Scott
