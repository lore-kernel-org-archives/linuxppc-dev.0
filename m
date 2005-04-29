Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A13F4679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 16:48:39 +1000 (EST)
Date: Fri, 29 Apr 2005 08:48:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Message-ID: <20050429064828.GA20003@wohnheim.fh-wedel.de>
References: <OF6EA2D85F.3FCDDAC2-ON85256FEB.00750EFB@teal.com>
	<20050422215339.GA9488@gate.ebshome.net>
	<1114207484.27280.9.camel@jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1114207484.27280.9.camel@jdub.homelinux.org>
Cc: Jeff.Fellin@rflelect.com, linuxppc-embedded@ozlabs.org
Subject: Re: Flash Statistics
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 22 April 2005 17:04:44 -0500, Josh Boyer wrote:
> > 
> > Flash datasheet must have this information.
> 
> They have information on the maximum number of writes per eraseblock,
> yes.  But I think Jeff is looking for some statistic gathering tools he
> can use to figure out how his application workload is effecting flash.
> I doubt that is in any datasheets ;).

Or in any currently existing mtd driver, for that matter.

Jörn

-- 
Fancy algorithms are buggier than simple ones, and they're much harder
to implement. Use simple algorithms as well as simple data structures.
-- Rob Pike
