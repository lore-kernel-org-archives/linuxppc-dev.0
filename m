Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17238.52279.428407.411558@cargo.ozlabs.ibm.com>
Date: Thu, 20 Oct 2005 08:44:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Becky Bruce <bgill@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0510191140350.29058@cde-tx32-ldt329.sps.mot.com>
References: <Pine.LNX.4.61.0510191140350.29058@cde-tx32-ldt329.sps.mot.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merge types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce writes:

> This patch merges types.h into include/asm-powerpc.  The only real changes
> here are that umode_t has become short instead of int in the 64-bit case,
> which appears to match what most other platforms have done.

Ummm, isn't that an ABI change?  We don't want to do that unless
you're completely absolutely positively sure it couldn't possibly
cause any userspace breakage.

Regards,
Paul.
