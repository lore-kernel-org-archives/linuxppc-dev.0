Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6C5967C67
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:13:17 +1100 (EST)
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0611020755k5be2d2ach388e921a29663bfa@mail.gmail.com>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125627.149261000@localhost.localdomain>
	<528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
	<20061102152527.GB4928@localhost.localdomain>
	<528646bc0611020755k5be2d2ach388e921a29663bfa@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:13:08 +1100
Message-Id: <1162505588.10630.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Then perhaps Efika should also be under platforms/mpc52xx?

Classifying platforms by their processor might not be the best idea... I
makes some sense when those platforms are basically reference designs
for the said processor but I yet have to be convinced it's really a good
thing in the long run :)

There will be a lot of platforms that will consist of basically once
signle source file. I think we need a directory for those. Maybe
platform/misc :) Or we could have them at the root of platforms/ in
fact... 

Paulus, what is your preference in that area ?

In the long run, it doesn't really matter in the sense that it's purely
the file location in the source tree, it has no effect on the content of
those files (+/- include path) or at runtime. You can still build kernel
with multiple images if the CPU cores are of the same category etc...
Thus, in this regard, it's almost cosmetic.
 
Cheers,
Ben.
