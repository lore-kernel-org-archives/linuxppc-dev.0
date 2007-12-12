Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07D1EDDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 02:19:14 +1100 (EST)
Message-ID: <475FFBEB.60005@freescale.com>
Date: Wed, 12 Dec 2007 09:19:07 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Re: [PATCH 1/2] qe: add function qe_clock_source()
References: <11967166791607-git-send-email-timur@freescale.com>
	<1196716680381-git-send-email-timur@freescale.com>
In-Reply-To: <1196716680381-git-send-email-timur@freescale.com>
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
> Add function qe_clock_source() which takes a string containing the name of a
> QE clock source (as is typically found in device trees) and returns the
> matching enum qe_clock value.
> 
> Update booting-without-of.txt to indicate that the UCC properties rx-clock
> and tx-clock are deprecated and replaced with rx-clock-name and tx-clock-name,
> which use strings instead of numbers to indicate QE clock sources.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

If there are no objections, I'd like this patch to be pulled into 2.6.25.  Thanks.

-- 
Timur Tabi
Linux kernel developer at Freescale
