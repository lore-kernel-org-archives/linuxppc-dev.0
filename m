Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.243])
	by ozlabs.org (Postfix) with ESMTP id 60B17DDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:50:11 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so495105hsb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 12:50:10 -0800 (PST)
Message-ID: <fa686aa40712211250l2645d34dr45c5be2bf1c9006d@mail.gmail.com>
Date: Fri, 21 Dec 2007 13:50:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/4] PowerPC: implement GPIO API
In-Reply-To: <20071221202824.GA4607@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071221202824.GA4607@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/21/07, Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> Also, in the upcoming kernels, there will be GPIOLIB[1] addition to
> the generic GPIO API, to support off-chip GPIO expanders (like MFDs
> on I2C/LBC). But so far we support on-chip GPIOs only, with single
> controller built-in.
>
> Changes since RFC:
> - Implemented #gpio-cells handling;
> - Per-bank spinlocks removed;
> - Added a patch which implements GPIO API for CPM1;
> - Few minor fixes.

Also need to add documentation to booting-without-of.txt.

In general this looks like a good direction, but I do not like the
hard linking for QE and CPM gpios to the 'top level' gpio API.  I
think I'd prefer this stuff to stay out of mainline until the gpiolib
stuff gets merged (which should be soon IIRC).

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
