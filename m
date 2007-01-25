Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17848.6331.164992.951431@cargo.ozlabs.ibm.com>
Date: Thu, 25 Jan 2007 13:40:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
In-Reply-To: <56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
	<20070124235150.GA26212@localhost.localdomain>
	<56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I think the problem is how to resolve the variations of the u-boot/ 
> ppcboot bd_t that changes from board to board and based on config.

The wrapper should be able to build bootable images for any of the
boards, that is, for any given bd_t variant, there should be a flag to
wrapper that tells it to build an image that understands that variant.

It's reasonable for arch/powerpc/boot/Makefile to pass different flags
to wrapper depending on the kernel config.  I don't want wrapper
itself, or anything it uses, to be config-dependent.

Paul.
