Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96699DE39C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 02:33:12 +1100 (EST)
Message-ID: <47F4F8B0.4090708@freescale.com>
Date: Thu, 03 Apr 2008 10:33:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
References: <20080311191744.GA10518@localhost.localdomain>	<200804031545.51834.laurentp@cse-semaphore.com>
	<20080403143052.GA5955@polina.dev.rtsoft.ru>
In-Reply-To: <20080403143052.GA5955@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linux-usb@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Yeah, I already posted a patch to deal with it, see
> http://ozlabs.org/pipermail/linuxppc-dev/2008-March/053249.html
> (btw... Scott, Timur did you have a chance to look into this?)

Seems to be okay.  I presume the code actually works with these changes. :-)

My only concern is that the functions are still called cpm_xxxx even though they
apply to the CPM and the QE.  Sure, the QE is really just CPM3, but I'd like to
see a nomenclature that's more inclusive.

We should also be able to get rid of cpm_alloc/free functions anyway, since
they're just front-ends to the rheap code.  But that's a problem for another time.

> Well, there is Linux CLK API (somewhat similar to GPIO API), but PowerPC
> doesn't use it yet.

Yeah, I noticed that too.  I'll add it to my to-do list, but I suspect that
someone else will get around to it before I do.

-- 
Timur Tabi
Linux kernel developer at Freescale
