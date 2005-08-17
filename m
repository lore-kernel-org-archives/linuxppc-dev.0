Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17154.38156.13295.731022@cargo.ozlabs.ibm.com>
Date: Wed, 17 Aug 2005 11:38:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508161700050.5751@nylon.am.freescale.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h> 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Made <asm/segment.h> a dummy include like it is in ppc64 and removed any
> users if it in arch/ppc.

Why can't we just delete asm-ppc/segment.h (and asm-ppc64/segment.h
too, for that matter) entirely?

Paul.
