Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9935F2BEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 22:32:30 +1100 (EST)
Received: from jack.colino.net (jack.colino.net [192.168.0.11])
	by paperstreet.colino.net (Postfix) with ESMTP id A664D73F3
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2004 12:31:39 +0100 (CET)
Date: Sat, 27 Nov 2004 12:31:11 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20041127123111.7e2db5bb@jack.colino.net>
In-Reply-To: <1101280145.4511.4.camel@gaston>
References: <1101280145.4511.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 24 Nov 2004 at 18h11, Benjamin Herrenschmidt wrote:

Hi Ben, 

> Ok, here's the 5th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.

noticed glxgears down to approx. 200fps. It used to be around 1500-1800,
xorg didn't change. It is also slower just after boot, no need to go to
sleep. 

Any idea about that?

-- 
Colin
  "The probability of someone watching you is proportional to the
   stupidity of your action."
