Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18076.46827.932735.590316@cargo.ozlabs.ibm.com>
Date: Tue, 17 Jul 2007 22:32:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] POWERPC:  Correct misspelled config variable in
	arch/powerpc/Kconfig.
In-Reply-To: <Pine.LNX.4.64.0707141820150.9894@localhost.localdomain>
References: <Pine.LNX.4.64.0707141820150.9894@localhost.localdomain>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert P. J. Day writes:

> -config CONFIG_CHECK_CACHE_COHERENCY
> +config CHECK_CACHE_COHERENCY

Please also fix the occurrence in
arch/powerpc/platforms/embedded6xx/Kconfig.

Paul.
