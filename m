Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55C8F67A6C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2005 07:22:01 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.esmtp.ibm.com [9.14.4.130])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j2EJasiX008690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2005 14:36:54 -0500
Date: Mon, 14 Mar 2005 13:36:40 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20050314193640.GE498@austin.ibm.com>
References: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
	<20050309200109.GG1220@austin.ibm.com>
	<20050310134216.5b9b27ef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050310134216.5b9b27ef.sfr@canb.auug.org.au>
From: Linas Vepstas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 10, 2005 at 01:42:16PM +1100, Stephen Rothwell was heard to remark:
> On Wed, 9 Mar 2005 14:01:09 -0600 Linas Vepstas <linas@austin.ibm.com> wrote:
> >
> > Why not #include <asm-generic/whatever.h> instead? 
> 
> Because I am talking about similarities between ppc and ppc64 not ppc64
> and the generic code (though there may be some of those to be exploited as
> well).

Hmm. well, yes. I just figured that since you're looking at this anyway,
may as well look to see if it can be made generic.

--linas
