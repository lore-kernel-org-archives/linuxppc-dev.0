Return-Path: <paulus@ozlabs.org>
Message-ID: <17290.28508.336476.478948@cargo.ozlabs.ibm.com>
Date: Mon, 28 Nov 2005 13:45:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1133016287.4044.65.camel@baythorne.infradead.org>
References: <1133016287.4044.65.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Make ARCH=ppc build again with new syscall path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> This makes ARCH=ppc build in your powerpc tree again, with the new
> syscall entry/exit path. 

Hmmm.  If we need to do this then maybe we should just get rid of the
arch/ppc versions of the relevant files and make ARCH=ppc use the
versions from arch/powerpc.

What do people think?  Do we make ARCH=ppc use more and more stuff
from arch/powerpc, and delete the duplicates from arch/ppc, or do
people want to be conservative and keep arch/ppc largely unchanged?
(I would prefer the former, myself.)

Paul.
