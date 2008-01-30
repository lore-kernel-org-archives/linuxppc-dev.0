Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 271C2DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 11:12:10 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so4313anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 16:12:09 -0800 (PST)
Message-ID: <fa686aa40801291612m9408b24idda1feac911f593b@mail.gmail.com>
Date: Tue, 29 Jan 2008 17:12:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Clone haleakala_defconfig from kilauea_defconfig
In-Reply-To: <20080129180712.1b37ba15@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080129160924.6186b6a1@zod.rchland.ibm.com>
	<C3C4ED97.D197%gerickson@nuovations.com>
	<20080129165941.1681842f@zod.rchland.ibm.com>
	<fa686aa40801291522y49c1b7e7n83c035f80fef1a12@mail.gmail.com>
	<20080129180712.1b37ba15@zod.rchland.ibm.com>
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

On 1/29/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Tue, 29 Jan 2008 16:22:52 -0700
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
> > Rather than adding more defconfigs, can we have a single defconfig for
> > 440 and another one for 405?  The configs directory is getting a bit
> > silly.
>
> You mean mulitplatform kernels?  Or what do you mean?

Yes, multiplatform kernels.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
