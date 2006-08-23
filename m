Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17643.61968.230622.260206@cargo.ozlabs.ibm.com>
Date: Wed, 23 Aug 2006 16:13:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
In-Reply-To: <526188FB-0FE5-40BA-AB21-EB491BB24911@kernel.crashing.org>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
	<526188FB-0FE5-40BA-AB21-EB491BB24911@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Maybe, I'm missing something, but why do we need this?  Why doesn't  
> iotype == UPIO_MEM work for the TSI?

It seems that there are some workarounds for TSI "features" in
drivers/serial/8250.c that this will invoke.

Paul.
