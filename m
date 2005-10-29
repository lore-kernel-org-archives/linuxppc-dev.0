Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17250.49231.248045.41302@cargo.ozlabs.ibm.com>
Date: Sat, 29 Oct 2005 10:20:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051028130246.459f1e9a.akpm@osdl.org>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<20051028103041.B15268@cox.net>
	<E053D1B7-2363-45D1-AEFC-83B8B5B4C4F8@freescale.com>
	<20051028130246.459f1e9a.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
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

Andrew Morton writes:

> Kumar Gala <kumar.gala@freescale.com> wrote:
> >
> > Can we ask Andrew to flush any ppc patches in -mm to linus before we  
> >  have Linus pull the merge tree.
> 
> Well I'd prefer that ;)

My concern is that if we do that we may end up losing some of the
changes from Andrew's patches when the merge goes in and/or creating a
nasty, difficult merge.

Probably the best thing is if I take the patches and apply them on top
of the merge tree (hacking them as necessary) and then get Linus to
pull.

Andrew, will I just grab the ones you listed from the latest -mm, or
will you send them to me?

Paul.
