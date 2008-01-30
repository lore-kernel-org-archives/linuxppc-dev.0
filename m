Return-Path: <SRS0=8N4g=SU=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9D546DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 17:22:20 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Clone haleakala_defconfig from kilauea_defconfig
Date: Wed, 30 Jan 2008 07:22:02 +0100
References: <20080129160924.6186b6a1@zod.rchland.ibm.com>
	<fa686aa40801291612m9408b24idda1feac911f593b@mail.gmail.com>
	<20080129184016.423aed6a@zod.rchland.ibm.com>
In-Reply-To: <20080129184016.423aed6a@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801300722.02966.sr@denx.de>
Cc: Stefan@ozlabs.org, Grant Erickson <gerickson@nuovations.com>,
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

On Wednesday 30 January 2008, Josh Boyer wrote:
> On Tue, 29 Jan 2008 17:12:09 -0700
>
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
> > On 1/29/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > > On Tue, 29 Jan 2008 16:22:52 -0700
> > >
> > > "Grant Likely" <grant.likely@secretlab.ca> wrote:
> > > > Rather than adding more defconfigs, can we have a single defconfig
> > > > for 440 and another one for 405?  The configs directory is getting a
> > > > bit silly.
> > >
> > > You mean mulitplatform kernels?  Or what do you mean?
> >
> > Yes, multiplatform kernels.
>
> Per IRC, I need patches or time ;)

As long as multiplatform is not available for 4xx I'm ok with this patch: 

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
