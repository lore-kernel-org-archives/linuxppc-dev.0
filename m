Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28D1E67A03
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 09:09:09 +1100 (EST)
Subject: Re: 2.6.16 does not boot on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dustin Lang <dalang@cs.ubc.ca>
In-Reply-To: <Pine.LNX.4.60.0603280630130.8520@tin.icics.ubc.ca>
References: <442925A8.6030004@rsbac.org>
	<Pine.LNX.4.60.0603280630130.8520@tin.icics.ubc.ca>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 09:08:56 +1100
Message-Id: <1143583736.2284.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michal Purzynski <michal@rsbac.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 2.6.16 works fine on my PowerBook 6,2.  When I patched up to 2.6.16 I 
> found I had to go through the config process - some of the PowerMac 
> options seem to have been turned off.  Maybe that was just me doing 
> something wrong, or maybe some of the Kconfig defaults changed?

Some stuffs changed in Kconfig causing it to stupidly drop most of the
pmac options ... 

Ben.
