Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18416.13294.32343.345798@cargo.ozlabs.ibm.com>
Date: Mon, 31 Mar 2008 11:44:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc: remove the non-functional PPC_PREP bits
In-Reply-To: <20080330224012.GD28445@cs181133002.pp.htv.fi>
References: <20080330224012.GD28445@cs181133002.pp.htv.fi>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk writes:

> Back in November 2005, the PPC_PREP bits under arch/powerpc/ were marked 
> as BROKEN due to not being working.
> 
> It doesn't seem to make much sense to keep this rudimentary support even 
> longer.

NAK - I have some patches that get ARCH=powerpc working on at least
some PRePs, and I plan to get them in before arch/ppc goes away.

Paul.
