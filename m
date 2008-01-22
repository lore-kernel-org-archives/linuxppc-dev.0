Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E9A5DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:42:12 +1100 (EST)
Message-ID: <47965506.9070305@freescale.com>
Date: Tue, 22 Jan 2008 14:41:42 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
In-Reply-To: <1201032819.5716.170.camel@rhino>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wade Farnsworth wrote:

> +
> +		ranges = <0 0 ff800000 00800000
> +			  1 0 fe000000 01000000
> +			  2 0 f8200000 00100000
> +			  3 0 f8100000 00100000>;
> +

I think you want just:

    ranges = <0 0 f8000000 8000000>

right?  And is it really on CS 0?

jdl
