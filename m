Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09F8DDDF3B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 04:14:10 +1100 (EST)
Date: Thu, 8 Feb 2007 11:11:27 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Rename ucc_slow_info.us_regs to .regs
In-Reply-To: <1170953251140-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0702081111110.29459@localhost.localdomain>
References: <1170953251140-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Feb 2007, Timur Tabi wrote:

> Rename the 'us_regs' field of the ucc_slow_info structure in ucc_slow.h
> to just 'regs'.  The equivalent field in the ucc_fast_info structure is
> also called 'regs', so this patch makes them comparable, and makes the
> code a little easier to read, because there already is a 'us_regs' in
> another ucc_slow structure.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

applied

- k
