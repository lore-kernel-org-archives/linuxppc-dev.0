Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C73B7DDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 02:19:48 +1100 (EST)
Message-ID: <475FFC0D.8040305@freescale.com>
Date: Wed, 12 Dec 2007 09:19:41 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Re: [PATCH 2/2] ucc_geth: use rx-clock-name and tx-clock-name device
	tree properties
References: <11967166791607-git-send-email-timur@freescale.com>
	<1196716680381-git-send-email-timur@freescale.com>
	<1196716685975-git-send-email-timur@freescale.com>
In-Reply-To: <1196716685975-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Updates the ucc_geth device driver to check the new rx-clock-name and
> tx-clock-name properties first.  If present, it uses the new function
> qe_clock_source() to obtain the clock source.  Otherwise, it checks the
> deprecated rx-clock and tx-clock properties.
> 
> Update the device trees for 832x, 836x, and 8568 to contain the new property
> names only.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

If there are no objections, I'd like this patch to be pulled into 2.6.25.  Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
