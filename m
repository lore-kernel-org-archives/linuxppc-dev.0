Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A1A4DDFF2
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:42:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l98KgNf9031420
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 16:42:23 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l98KgM74374792
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:42:22 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l98KgMrR029073
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:42:22 -0600
Date: Mon, 8 Oct 2007 15:42:21 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
Message-ID: <20071008204221.GA11512@austin.ibm.com>
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<D6497F34-ECE1-481E-B969-E7DDC60BAAFD@kernel.crashing.org>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
	<27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
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

On Mon, Oct 08, 2007 at 02:41:54PM -0500, Kumar Gala wrote:
> 
> On Oct 8, 2007, at 2:03 PM, Grant Likely wrote:
> 
> >>> I can't see a good reason for eval board platform code to mess with
> >>> the
> >>> ROOT_DEV value instead of using the default behaviour (so I'm  
> >
> > Powermac and pseries also do this weirdness.  Should it be removed
> > from there too?
> 
> We need benh to make a comment about powermac.
> 
> I think its ok to remove everywhere but we should see if he has any  
> issue.

Ack. I see no problems in removing it.

--linas
