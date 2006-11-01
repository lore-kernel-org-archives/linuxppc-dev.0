Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17737.8977.580483.293733@cargo.ozlabs.ibm.com>
Date: Thu, 2 Nov 2006 09:43:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] powerpc: Eliminate "exceeds stub group size" linker
	warning
In-Reply-To: <Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
References: <17735.61916.194247.973705@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0611010647040.25218@g5.osdl.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> Hmm. I'd love to get rid of the warnings, because they obviously mean that 
> I don't look at warnings much at all ("they're all bogus"), but this patch 
> must be against some version of arch/powerpc/kernel/head_64.S that I've 
> never seen.

Sorry, my mistake, it was against the "master" head of the powerpc.git
tree.  New patch coming.

Paul.
