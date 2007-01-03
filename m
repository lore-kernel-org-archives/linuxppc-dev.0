Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17818.64827.568060.143841@cargo.ozlabs.ibm.com>
Date: Wed, 3 Jan 2007 11:47:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
In-Reply-To: <0e6a409d0ffedd23495d2aed672632dd@kernel.crashing.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<535725c5c6010b6283b0ed0826dd469d@kernel.crashing.org>
	<20070102190944.70c19799@mlejnas.priv.castalie.org>
	<0e6a409d0ffedd23495d2aed672632dd@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Ah.  lis and ori.  HI16 is just fine there -- but note that
> that doesn't use an add insn.  You're patching the function

lis is an addis with rA=0, don't forget...

> "apply_relocate_add()", so I guess some more work is needed?

Looks fine as it is to me.

Paul.
