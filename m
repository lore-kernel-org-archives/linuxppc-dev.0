Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17404.20246.361572.784670@cargo.ozlabs.ibm.com>
Date: Wed, 22 Feb 2006 22:46:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Curry <pacman@TheWorld.com>
Subject: Re: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
In-Reply-To: <200602212339.SAA1138491@shell.TheWorld.com>
References: <200602212339.SAA1138491@shell.TheWorld.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Curry writes:

> altivec_unavailable_exception is called without setting r3... it looks like
> the r3 that actually gets passed in as struct pt_regs *regs is the
> undisturbed value of r3 at the time the altivec instruction was encountered.

Nice catch!

Thanks,
Paul.
