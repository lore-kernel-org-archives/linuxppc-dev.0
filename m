Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17186.57339.793780.27220@cargo.ozlabs.ibm.com>
Date: Sat, 10 Sep 2005 23:30:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20050910201222.6861b172.sfr@canb.auug.org.au>
References: <E1EDqf2-0001Rh-Da@jdl.com>
	<20050910201222.6861b172.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH ppc Merge asm-ppc*/posix_types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> On 32 bit, int == long, so the last three could be removed from the ifdef
> by making them {unsigned }long ...

Yeah, I tried changing those to unsigned long once, long ago, and ran
into problems because this header gets used in userspace, and gcc
seems to have a fixed idea that size_t is unsigned int on ppc32.
I think we should leave it as unsigned int.

Paul.
