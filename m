Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18486.10385.934128.122054@cargo.ozlabs.ibm.com>
Date: Fri, 23 May 2008 12:14:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2] powerpc: rmb fix
In-Reply-To: <20080521153247.GF8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<1211383623.8297.197.camel@pasglop>
	<20080521153247.GF8897@wotan.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin writes:

> More than one device driver does raw/relaxed io accessors and expects the
> *mb functions to order them.

Can you point us at an example?

I don't think the semantics of the raw accessors are particularly well
defined (it's not even defined what endianness the data comes back in)
so I'd be surprised if there was any real definition of their
behaviour w.r.t. barriers.

Paul.
