Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC7F1DDFD8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:44:09 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l98LjZtv008087
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 17:45:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l98Li5kN089318
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 17:44:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l98LhtjN022388
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 17:43:55 -0400
Date: Mon, 8 Oct 2007 16:43:44 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
Message-ID: <20071008214344.GF4350@austin.ibm.com>
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<D6497F34-ECE1-481E-B969-E7DDC60BAAFD@kernel.crashing.org>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
	<27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
	<20071008204221.GA11512@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071008204221.GA11512@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 08, 2007 at 03:42:21PM -0500, Linas Vepstas wrote:
> On Mon, Oct 08, 2007 at 02:41:54PM -0500, Kumar Gala wrote:
> > 
> > On Oct 8, 2007, at 2:03 PM, Grant Likely wrote:
> > 
> > >>> I can't see a good reason for eval board platform code to mess with
> > >>> the
> > >>> ROOT_DEV value instead of using the default behaviour (so I'm  
> > >
> > > Powermac and pseries also do this weirdness.  Should it be removed
> > > from there too?
> > 
> > We need benh to make a comment about powermac.
> > 
> > I think its ok to remove everywhere but we should see if he has any  
> > issue.
> 
> Ack. I see no problems in removing it.

Err. I meant my comment to be of limited scope: "for pseries". 
I know nothing of other platforms.

--linas
