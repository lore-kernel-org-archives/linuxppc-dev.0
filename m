Return-Path: <anton@ozlabs.org>
Date: Fri, 6 Aug 2010 16:51:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
Message-ID: <20100806065112.GT29316@kryten>
References: <20100806045315.GR29316@kryten> <1281071865.2168.28.camel@pasglop>
	<20100806055640.GS29316@kryten> <1281075949.2168.31.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281075949.2168.31.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> remind me why we need to do that runlatch thing on these CPUs at all ?

The PMU uses it so events can be constructed that count only non idle cycles.
I think the power management hardware on POWER6 and POWER7 also use the
runlatch state to determine how busy a CPU is.

Anton
