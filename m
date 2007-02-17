Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B77DCDDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 09:34:11 +1100 (EST)
Date: Sat, 17 Feb 2007 16:31:09 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: clean up ucc_slow.c and ucc_fast.c
In-Reply-To: <11716866811378-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0702171630560.11585@localhost.localdomain>
References: <11716866811378-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 Feb 2007, Timur Tabi wrote:

> Refactored and cleaned up ucc_fast.c and ucc_slow.c so that the two files
> look more alike and are easier to read.  Removed uccf_printk() and related
> functions, because they were just front-ends to printk().  Fixed some
> spacing and tabbing issues.  Minor optimizations of some code.  Changed
> the type of some variables to their proper type (mostly buffer
> descriptors).
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

applied.

- k
