Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8382DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 07:12:00 +1000 (EST)
Date: Wed, 27 Jun 2007 01:11:49 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Message-ID: <20070627011149.14bf9fba@localhost.localdomain>
In-Reply-To: <200706261903.41801.arnd@arndb.de>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
	<1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
	<200706261903.41801.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Jun 2007 19:03:41 +0200
Arnd Bergmann wrote:

> On Tuesday 26 June 2007, Segher Boessenkool wrote:
> > Well the arch/ppc tree is basically frozen already, all Freescale
> > stuff got moved over already as far as I can see, and 4xx has
> > started moving.
> 
> 8xx has been moved over, but last time I tried, it was not possible
> to actually compile that code. Note sure if the arch/ppc version of
> it is in a much better shape though.
> 
8xx should be ok now, yet, we have to be aware that only 2 platforms are in arch/powerpc
and there are plenty in arch/ppc still.

> 82xx seems to be in a similar state to 4xx, with a single platform
> moved over, but most of the code still being arch/ppc only.
> 
The situation is better here - most stuff is very similar to what is done (except sandpoint but that's another story)
and the number of platforms is reasonable.

for the 8xx feild, there is quite a lot of boards...
with all the "specifics", it is nearly impossible to provide robust port without actual HW
(or, heh, the result won't work at all).

> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
