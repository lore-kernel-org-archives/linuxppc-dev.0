Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74598DDFEE
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:56:43 +1000 (EST)
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<D6497F34-ECE1-481E-B969-E7DDC60BAAFD@kernel.crashing.org>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
	<27C642CB-ACC0-4E3E-85AA-8319F56364EB@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 06:56:30 +1000
Message-Id: <1191876991.6355.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-08 at 14:41 -0500, Kumar Gala wrote:
> > Powermac and pseries also do this weirdness.  Should it be removed
> > from there too?
> 
> We need benh to make a comment about powermac.
> 
> I think its ok to remove everywhere but we should see if he has any  
> issue.

PowerMac has some weirdo auto-detection code for root... I don't want to
remove it just yet.

Ben
