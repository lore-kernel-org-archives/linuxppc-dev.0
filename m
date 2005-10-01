Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17214.632.655003.750819@cargo.ozlabs.ibm.com>
Date: Sat, 1 Oct 2005 13:28:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20051001121714.1b5886aa.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000001.1f1d8c48.sfr@canb.auug.org.au>
	<52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
	<20051001121714.1b5886aa.sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/9] powerpc: merge idle_power4.S and fixup traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> My first attempt at the merge was a real mess and a right pain, so I put
> the two files in as a compromise.  However, I have made another attempt
> and ,although it took a while,  it seems to be going ok.  How about we put
> the two in for now (as that will allow the merge of more platforms to
> continue) and I will supply a further patch in a few days that combines
> the two trapsxx.c files?

In that case, what is the advantage of having two traps*.c files in
arch/powerpc/kernel instead of having them in arch/ppc*/kernel?

Paul.
