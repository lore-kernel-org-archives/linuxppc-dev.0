Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A50ADDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 05:19:17 +1100 (EST)
Date: Wed, 14 Mar 2007 13:15:57 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: automatically select QE options
In-Reply-To: <1173732027723-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0703141315430.18994@localhost.localdomain>
References: <1173732027723-git-send-email-timur@freescale.com>
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

On Mon, 12 Mar 2007, Timur Tabi wrote:

> Change the Kconfig files so that the Freescale QE options are automatically
> selected if a QE device is selected.  Previously, you'd need to manually
> select UCC_FAST if you want any "fast" UCC devices, such as Gigabit Ethernet.
> Now, the QE Gigabit Ethernet option is always available if the device has a
> QE, and UCC_FAST is automatically enabled.  A side-effect is that the
> "QE Options" menu no longer exists.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

applied.

- k
