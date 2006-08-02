Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17616.17129.964122.125259@cargo.ozlabs.ibm.com>
Date: Wed, 2 Aug 2006 16:15:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
In-Reply-To: <17616.12251.339657.215571@cargo.ozlabs.ibm.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wrote:

> The ops structure seems like a reasonable concept, but I question
> whether we need to have platform_ops separate from fw_ops, since the
> firmware is essentially part of the implementation of the platform.
> Also I don't see why we need to do a double indirection to get to each
> ops function.

Thinking about this a bit more, why do we need the indirect function
calls at all?  Do we ever want to be able to choose (e.g.) one of
several possible console implementations at runtime?  Don't we know at
compile time which one we will be using, and thus can't we use the
linker to make the necessary linkages?

Regards,
Paul.
