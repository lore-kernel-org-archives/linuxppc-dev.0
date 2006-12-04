Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17779.38056.64501.458056@cargo.ozlabs.ibm.com>
Date: Mon, 4 Dec 2006 14:23:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] Add support for FP emulation for the e300c2 core
In-Reply-To: <20061122142020.3e700bac.kim.phillips@freescale.com>
References: <20061122142020.3e700bac.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> The e300c2 has no FPU.  Its MSR[FP] is grounded to zero.  If an attempt
> is made to execute a floating point instruction (including floating-point
> load, store, or move instructions), the e300c2 takes a floating-point
> unavailable interrupt (IVOR7).

Can't you just point IVOR7 at the program check handler on these cpus?

Paul.
