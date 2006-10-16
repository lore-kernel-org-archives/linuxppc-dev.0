Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5069167C4F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 02:51:43 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9GGpfkt023626
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 12:51:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9GGpevs199644
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 10:51:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9GGpe0T030164
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 10:51:40 -0600
Date: Mon, 16 Oct 2006 11:51:40 -0500
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Recently removed io accessors
Message-ID: <20061016165140.GB6537@austin.ibm.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<17712.7972.493547.357685@cargo.ozlabs.ibm.com>
	<8764ent8j4.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8764ent8j4.fsf@sleipner.barco.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 14, 2006 at 01:57:03PM +0200, Peter Korsgaard wrote:
> PM> code up a loop of readw (or equivalent) in the driver with a big
> PM> comment explaining why you need to do it that way.
> 
> It doesn't have to be readw (16bit accesses). Enabling the BE mode and
> using _outsl/_insl (32bit access with byteswap) works fine.

I think Paul was trrying to say that it might be easier just to 
16-bit words. Are you trying to use 32-bit access due to performance
concerns?

--linas
