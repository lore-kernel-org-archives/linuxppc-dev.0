Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB7C4DE322
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 02:16:37 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m7MGGSaU011760
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 09:16:30 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7MGEbOX018094
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 11:14:37 -0500 (CDT)
Date: Fri, 22 Aug 2008 11:14:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Message-ID: <20080822161436.GB15341@ld0162-tx32.am.freescale.net>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 06:46:20AM -0400, Martyn Welch wrote:
> +		enet0: ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x00024000 0x00001000>;
> +			mac-address = [ 00 00 00 00 00 00 ]; // set by u-boot

local-mac-address

-Scott
