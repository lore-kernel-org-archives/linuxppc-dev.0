Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7E2FDDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:29:34 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q1Uusq2560128
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:30:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5Q1X4EA150868
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:33:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5Q1TWj3008736
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:29:32 +1000
Date: Tue, 26 Jun 2007 11:23:19 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: libfdt merged into DTC repo!
Message-ID: <20070626012319.GB29641@localhost.localdomain>
References: <E1I2pUz-0008MH-3F@jdl.com>
	<1182783063.23775.40.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1182783063.23775.40.camel@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 09:51:03AM -0500, Josh Boyer wrote:
> On Mon, 2007-06-25 at 09:25 -0500, Jon Loeliger wrote:
> > Folks,
> > 
> > David Gibson has successfully wrestled the libfdt legal beast!
> > As a result, I have merged the current versions of the libfdt
> > into the DTC repository as maintained on jdl.com.
> 
> Cool.  Congrats David.
> 
> So I'm assuming the DTC git tree will be the canonical source for libfdt
> then?

That's correct.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
