Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4805EDDFD0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:37:20 +1100 (EST)
Message-ID: <47910D03.5060207@freescale.com>
Date: Fri, 18 Jan 2008 13:33:07 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 1/2] [POWERPC] mpc5200: normalize compatible property
	bindings
References: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
	<20080118170443.10592.97538.stgit@trillian.secretlab.ca>
In-Reply-To: <20080118170443.10592.97538.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks fine to me.

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Update MPC5200 drivers to also look for compatible properties in the
> form "fsl,mpc5200-*" to better conform to open firmware generic names
> recommended practice as published here:
>
> http://www.openfirmware.org/1275/practice/gnames/gnamv14a.html
>
> This patch should *not* break compatibility with older device trees
> which do not use the 'fsl,' prefix.  The drivers will still bind against
> the older names also.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>   
