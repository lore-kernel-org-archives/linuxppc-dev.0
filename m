Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17922.28062.992264.172708@cargo.ozlabs.ibm.com>
Date: Thu, 22 Mar 2007 22:50:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Use mtocrf in asm when CONFIG_POWER4_ONLY=y
In-Reply-To: <8f820a3c81d934b09c621e9fe55dd248@kernel.crashing.org>
References: <20070322020925.GA13114@lixom.net>
	<8f820a3c81d934b09c621e9fe55dd248@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Does anyone know which CPUs that don't implement mtocrf
> don't treat it identical to mtcrf?  That would allow to
> widen when we use mtocrf.  Or perhaps it's really time
> for an "asm alternatives" run-time patch thing now :-)

POWER3 takes a 0x700 interrupt when it sees mtocrf, unfortunately.

Paul.
