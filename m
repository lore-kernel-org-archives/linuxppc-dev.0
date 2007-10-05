Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40DBEDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 02:03:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l95Esxn2018060
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Oct 2007 10:54:59 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l95G3NYs373794
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Oct 2007 10:03:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l95G3MWm026754
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Oct 2007 10:03:23 -0600
Date: Fri, 5 Oct 2007 11:03:22 -0500
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 -- powerpc rtas panic
Message-ID: <20071005160322.GN4338@austin.ibm.com>
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<20070924123531.GC30855@shadowen.org>
	<20071002232819.GN4338@austin.ibm.com>
	<20071003002646.GD9814@bakeyournoodle.com>
	<1191371416.8073.1.camel@concordia>
	<20071003011909.GG9814@bakeyournoodle.com>
	<29495f1d0710041701g4ed73441ie583058c78f95857@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29495f1d0710041701g4ed73441ie583058c78f95857@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 04, 2007 at 05:01:47PM -0700, Nish Aravamudan wrote:
> On 10/2/07, Tony Breeds <tony@bakeyournoodle.com> wrote:
> > On Wed, Oct 03, 2007 at 10:30:16AM +1000, Michael Ellerman wrote:
> >
> > > I realise it'll make the patch bigger, but this doesn't seem like a
> > > particularly good name for the variable anymore.
> >
> > Sure, what about?
> >
> > Clarify when RTAS logging is enabled.
> >
> > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> 
> For what it's worth, on a different ppc64 box, this resolves a similar
> panic for me.
> 
> Tested-by: Nishanth Aravamudan <nacc@us.ibm.com>

For the reasons explained, I'd really like to nack Tony's patch.

--linas
