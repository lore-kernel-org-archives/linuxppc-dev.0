Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D81DF2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2004 11:51:37 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20041124085054.14a89f5f@pirandello>
References: <1101280145.4511.4.camel@gaston>
	<20041124085054.14a89f5f@pirandello>
Content-Type: text/plain
Date: Thu, 25 Nov 2004 11:51:12 +1100
Message-Id: <1101343872.4634.29.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2004-11-24 at 08:50 +0100, Colin Leroy wrote:
> On 24 Nov 2004 at 18h11, Benjamin Herrenschmidt wrote:
> 
> Hi Ben, 
> 
> > Ok, here's the 5th version of the sleep patch for ATI based albooks &
> > iBook G4. Other machine users, please test too as it may cause
> > regressions (or improvements) as well.
> 
> Care to apply the attached patch to your tree ? It would avoid me 
> a failing hunk when applying your patches, and also that's what 
> AppleGmacEthernet does.

Ok. Does WOL works btw ?

Ben.
