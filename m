Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F94ADDF19
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 00:51:35 +1100 (EST)
Date: Mon, 23 Mar 2009 08:50:03 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Please pull from 'merge' branch
In-Reply-To: <Pine.LNX.4.64.0903230843310.21260@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0903230849130.21310@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0903230843310.21260@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Mar 2009, Kumar Gala wrote:

> Please pull from 'merge' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge
>
> to receive the following updates:
>
>  arch/powerpc/kernel/head_32.S |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Kumar Gala (1):
>       powerpc/mm: Fix Respect _PAGE_COHERENT on classic ppc32 SW TLB load machines
>

This should be picked up for .29.  Grant picked up the wrong verson of the
patch and we need the minor fixes to get to the right code that this
patch/pull request deals with.

- k
