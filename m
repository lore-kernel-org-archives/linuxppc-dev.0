Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92DC5DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 11:08:16 +1100 (EST)
Date: Tue, 29 Jan 2008 18:07:12 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] 4xx: Clone haleakala_defconfig from kilauea_defconfig
Message-ID: <20080129180712.1b37ba15@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40801291522y49c1b7e7n83c035f80fef1a12@mail.gmail.com>
References: <20080129160924.6186b6a1@zod.rchland.ibm.com>
	<C3C4ED97.D197%gerickson@nuovations.com>
	<20080129165941.1681842f@zod.rchland.ibm.com>
	<fa686aa40801291522y49c1b7e7n83c035f80fef1a12@mail.gmail.com>
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

On Tue, 29 Jan 2008 16:22:52 -0700
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On 1/29/08, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > On Tue, 29 Jan 2008 14:49:59 -0800
> > Grant Erickson <gerickson@nuovations.com> wrote:
> >
> > > On 1/29/08 2:09 PM, Josh Boyer wrote:
> > > > On Tue, 29 Jan 2008 14:05:41 -0800
> > > > Grant Erickson <gerickson@nuovations.com> wrote:
> > > >
> > > >> Is there a patch pending to for 'arch/powerpc/configs/haleakala_defconfig'?
> > > >
> > > > Not to my knowledge.
> > > >
> > > >> I did not see one in either of:
> > > >>
> > > >>     git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
> > > >>     git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> > > >>
> > > >> If no patch is pending, to whom do I submit such a patch? It'll simply be a
> > > >> near clone of 'kilauea_defconfig', save the "CONFIG_DEVICE_TREE" entry.
> > > >
> > > > Send one to me.  CC Stefan Roese please.
> > > >
> > > > josh
> > >
> > > * Allow for 'make haleakala_defconfig' by providing a default configuration
> > >   for the AMCC PowerPC 405EXr "Haleakala" board.
> > >
> >
> > As silly as it sounds, I need a Signed-off-by for this.  Could you read
> > Documentation/SubmittingPatches section 12 and just reply to this with
> > a Signed-off-by line?
> 
> Rather than adding more defconfigs, can we have a single defconfig for
> 440 and another one for 405?  The configs directory is getting a bit
> silly.

You mean mulitplatform kernels?  Or what do you mean?

josh
