Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A23967A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 23:59:04 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Jon Loeliger'" <jdl@jdl.com>
Subject: RE: cpu power "management" for non-dfs chips with no pmu (for
	instance, 750cxe and mpc7447 in pegasos)
Date: Fri, 23 Jun 2006 08:58:56 -0500
Message-ID: <01ca01c696cd$2e453f30$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <E1FtlnK-0007Zt-Tx@jdl.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have nothing real to contribute other than I would like to see it :)

Before I asked I checked Google (as is expected of anyone these days)
and found some discussions on debian-powerpc from 2002 but nobody
really did anything and nothing really came of it. I know 4 years later
all we have is powernowd which pokes up cpufreq which only supports
DFS and certain kinds of Mac PMU. 

ICTC is such a simple thing to support and you can slow down the CPU
pretty comprehensively (from halving to 255x in theory) with an on and
off flag. I am surprised nobody implemented a cpufreq governer even if
it is totally useless and gives no perceivable benefits..

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations


> -----Original Message-----
> From: Jon Loeliger [mailto:jdl@jdl.com] 
> Sent: Friday, June 23, 2006 8:34 AM
> To: matt@genesi-usa.com
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: cpu power "management" for non-dfs chips with no 
> pmu (for instance, 750cxe and mpc7447 in pegasos) 
> 
> So, like, the other day "Matt Sealey" mumbled:
> > 
> > I am basically trying to evaluate if we can do ANYTHING to reduce 
> > power consumption of systems which are idle, as I have noticed that 
> > ...
> > 
> > Comments? :)
> 
> Hi Matt,
> 
> There is an effort afoot to revitalize some of the Linux 
> Power Management issues, erm, currently going on over on the 
> linux-pm list these days.  No immediate results (yet), but 
> there is some concerted effort.  It should include some 
> PowerPC presence.
> 
> Please feel free to contribute, of course. :-)
> 
> jdl
> 
