Return-Path: <akpm@osdl.org>
Date: Fri, 28 Oct 2005 22:59:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <20051028225917.2873a74e.akpm@osdl.org>
In-Reply-To: <17251.3222.175214.996295@cargo.ozlabs.ibm.com>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<20051028103041.B15268@cox.net>
	<E053D1B7-2363-45D1-AEFC-83B8B5B4C4F8@freescale.com>
	<20051028130246.459f1e9a.akpm@osdl.org>
	<17250.49231.248045.41302@cargo.ozlabs.ibm.com>
	<20051028174029.24d4dbb9.akpm@osdl.org>
	<17251.3222.175214.996295@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew Morton writes:
> 
> > I'll mail them all over.
> 
> Got them, thanks.  I'm going to drop 06, 12, 13, 18, 19, 20, 21, and
> 37 for now.  The rest I have committed to the powerpc-merge tree.
> 
> The reasons for dropping them are:
> 
> 06 - need to discuss the specifics of the patch with Marcelo
> 12, 13 - going through netdev tree
> 18 - it seems there is still ongoing discussion about whether this is
>      the best approach
> 19, 20, 21 - BenH's SMU stuff, which he told me he would rebase on
>      top of the merge tree
> 37 - I want the patch done a little differently

OK, well I'll probably drop all those patches as well - hopefully all the
originators know what's going on and nothing will fall through a crack.
