Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17019.64610.454584.566932@cargo.ozlabs.ibm.com>
Date: Sat, 7 May 2005 09:23:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0505061336250.28348@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0505061336250.28348@nylon.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: Fix POWER3/POWER4 compiler error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> In separating out support for hardware floating point we missed the fact that
> both POWER3 and POWER4 have HW FP.  Enable CONFIG_PPC_FPU for POWER3 
> and POWER4 fixes the issue.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Acked-by: Paul Mackerras <paulus@samba.org>
