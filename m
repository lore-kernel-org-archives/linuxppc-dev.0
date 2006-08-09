Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E5AD679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:00:56 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Paul Mackerras'" <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: Who cares about PReP?
Date: Wed, 9 Aug 2006 17:00:50 +0200
Message-ID: <013401c6bbc4$9d2acd90$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


QEMU PPC implements a PReP system too.

Probably a good place to test without needing a real system.

However it's the kind of thing you'd want to throw a CHRP
ROM onto in the end, and forget PReP for emulation (after
all, nobody makes 'em anymore).

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
 

> -----Original Message-----
> From: linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org] 
> On Behalf Of Paul Mackerras
> Sent: Monday, August 07, 2006 8:59 AM
> To: linuxppc-dev@ozlabs.org
> Subject: Who cares about PReP?
> 
> I started looking at moving the PReP code over to 
> arch/powerpc.  I am struck by how many ifdefs there are in 
> there to set things up for particular individual PReP 
> implementations.  We can do better than that, I'm sure, but 
> the issue becomes one of testing.  The only PReP I have here 
> is an RS/6000 43p-140.
> 
> Who else has a PReP system and would be willing to do some 
> testing and debugging?  If so, what sort of PReP is it?
> 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
