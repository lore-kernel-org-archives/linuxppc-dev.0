Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64D9CDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 11:41:20 +1100 (EST)
Date: Tue, 29 Jan 2008 18:40:16 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] 4xx: Clone haleakala_defconfig from kilauea_defconfig
Message-ID: <20080129184016.423aed6a@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40801291612m9408b24idda1feac911f593b@mail.gmail.com>
References: <20080129160924.6186b6a1@zod.rchland.ibm.com>
	<C3C4ED97.D197%gerickson@nuovations.com>
	<20080129165941.1681842f@zod.rchland.ibm.com>
	<fa686aa40801291522y49c1b7e7n83c035f80fef1a12@mail.gmail.com>
	<20080129180712.1b37ba15@zod.rchland.ibm.com>
	<fa686aa40801291612m9408b24idda1feac911f593b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan@ozlabs.org, Roese <sr@denx.de>,
	Grant Erickson <gerickson@nuovations.com>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008 17:12:09 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 1/29/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > On Tue, 29 Jan 2008 16:22:52 -0700
> > "Grant Likely" <grant.likely@secretlab.ca> wrote:
> >
> > > Rather than adding more defconfigs, can we have a single defconfig for
> > > 440 and another one for 405?  The configs directory is getting a bit
> > > silly.
> >
> > You mean mulitplatform kernels?  Or what do you mean?
> 
> Yes, multiplatform kernels.

Per IRC, I need patches or time ;)

josh
