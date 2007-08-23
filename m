Return-Path: <fernando@oss.ntt.co.jp>
Received: from serv1.oss.ntt.co.jp (ns.oss.ntt.co.jp [222.151.198.98])
	by ozlabs.org (Postfix) with ESMTP id 2D6CADDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 15:29:22 +1000 (EST)
Subject: Re: [PATCH] ppc: remove unused amiga_request_irq and mach_request_irq
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070822182859.GX4261@austin.ibm.com>
References: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
	<18124.1417.743332.974941@cargo.ozlabs.ibm.com>
	<20070822182859.GX4261@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Aug 2007 14:29:19 +0900
Message-Id: <1187846959.12759.41.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-22 at 13:28 -0500, Linas Vepstas wrote: 
> On Wed, Aug 22, 2007 at 07:44:41PM +1000, Paul Mackerras wrote:
> > Fernando Luis Vázquez Cao writes:
> > 
> > > amiga_request_irq and mach_request_irq are never used, so delete them.
> > 
> > OK, but is there a particular reason you want to do this?
> > 
> > The whole of arch/ppc is going away eventually, so I don't think we
> > need to remove it piece by piece.
> 
> Its often easier to port/move stuff if you clean it up first.
Agreed. It would make things easier for me too.

Fernando
