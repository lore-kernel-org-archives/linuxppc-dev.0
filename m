Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 117ABDDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 04:37:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l7MHUt5Y004163
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:30:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7MIaDIe269122
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 12:37:52 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7MITLkv024785
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 12:29:22 -0600
Date: Wed, 22 Aug 2007 13:28:59 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: remove unused amiga_request_irq and mach_request_irq
Message-ID: <20070822182859.GX4261@austin.ibm.com>
References: <1187767237.25624.11.camel@sebastian.kern.oss.ntt.co.jp>
	<18124.1417.743332.974941@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <18124.1417.743332.974941@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org,
	Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 07:44:41PM +1000, Paul Mackerras wrote:
> Fernando Luis Vázquez Cao writes:
> 
> > amiga_request_irq and mach_request_irq are never used, so delete them.
> 
> OK, but is there a particular reason you want to do this?
> 
> The whole of arch/ppc is going away eventually, so I don't think we
> need to remove it piece by piece.

Its often easier to port/move stuff if you clean it up first.

--linas
