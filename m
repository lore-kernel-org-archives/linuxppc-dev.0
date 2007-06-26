Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA06BDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 04:51:27 +1000 (EST)
In-Reply-To: <200706261903.41801.arnd@arndb.de>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
	<1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
	<200706261903.41801.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DE28F767-7CD6-4618-8CD4-63EC5E296E2E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Date: Tue, 26 Jun 2007 13:51:16 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2007, at 12:03 PM, Arnd Bergmann wrote:

> On Tuesday 26 June 2007, Segher Boessenkool wrote:
>> Well the arch/ppc tree is basically frozen already, all Freescale
>> stuff got moved over already as far as I can see, and 4xx has
>> started moving.
>
> 8xx has been moved over, but last time I tried, it was not possible
> to actually compile that code. Note sure if the arch/ppc version of
> it is in a much better shape though.
>
> 82xx seems to be in a similar state to 4xx, with a single platform
> moved over, but most of the code still being arch/ppc only.

Scott Wood is look at both of these post OLS.

- k
