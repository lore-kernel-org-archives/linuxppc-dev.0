Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12470DDFCA
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 21:15:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67BFMfE006736
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 07:15:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67BFMA0163958
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 05:15:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67BFLxO015368
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 05:15:22 -0600
Date: Mon, 7 Jul 2008 07:12:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [Bugme-new] [Bug 11027] New: random forward time jumps
Message-ID: <20080707071200.0139e195@zod.rchland.ibm.com>
In-Reply-To: <20080704033254.GE12945@secretlab.ca>
References: <bug-11027-10286@http.bugzilla.kernel.org/>
	<20080702110614.4bd45cce.akpm@linux-foundation.org>
	<1215132417.7849.2.camel@localhost>
	<20080703175932.53ec7151.akpm@linux-foundation.org>
	<20080704015022.GV20457@bakeyournoodle.com>
	<1215136480.7849.12.camel@localhost>
	<20080704033254.GE12945@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 3 Jul 2008 21:32:54 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Fri, Jul 04, 2008 at 11:54:40AM +1000, Michael Ellerman wrote:
> > On Fri, 2008-07-04 at 11:50 +1000, Tony Breeds wrote:
> > > On Thu, Jul 03, 2008 at 05:59:32PM -0700, Andrew Morton wrote:
> > >  
> > > > Nope, the only account matching .*ppc.* and .*power.* is
> > > > platform_ppc-32@kernel-bugs.osdl.org.  (I have elevated bugzilla perms
> > > > so I can can query the users list) (everyone should have this - it's
> > > > handy).
> > > > 
> > > > There is a category "Platform Specific/Hardware"/PPC-64.  Those go to
> > > > anton@samba.org.
> > > 
> > > Can you get this changed to platform_ppc-64@kernel-bugs.osdl.org
> > > (obvisouly this'll need to be created)?
> > 
> > Just to be clear, Anton will still fix all the bugs single-handedly in
> > his sleep .. we'll just be able to watch :)
> 
> He needs to use one of his hands?  I though Anton just dreamt about the
> bug and it would flee in terror.

Indeed.  Though he might have trouble with his latest nemesis,
PowerPoint.

josh
