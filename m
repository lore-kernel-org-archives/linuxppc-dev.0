Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 59448DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 14:35:43 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1217464wag
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 21:35:42 -0700 (PDT)
Message-ID: <fa686aa40708102135h1a95bd3aqc55dcdc2081160f9@mail.gmail.com>
Date: Fri, 10 Aug 2007 22:35:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <004650C7-11FB-4A77-A797-148A7FDBD29D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<200708070124.04748.arnd@arndb.de>
	<fa686aa40708091154t55ca4df7q7be2acf5662e6076@mail.gmail.com>
	<004650C7-11FB-4A77-A797-148A7FDBD29D@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/10/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 9, 2007, at 1:54 PM, Grant Likely wrote:
>
> > On 8/6/07, Arnd Bergmann <arnd@arndb.de> wrote:
> > Naahh, this is pretty benign stuff.  I say let it go in.  :-)
> >
> > These changes are low risk and they don't hurt anything.  If Virtex
> > support worked in arch/powerpc then I'd agree, but for now it allows
> > us to keep the virtex device driver support somewhat current.
>
> We've clearly stated for a while that only bug fixes should be going
> into arch/ppc.  This looks like new board support.
>
> Also, be aware that arch/ppc is going away in Jun 2008. :)

So it only lives in the tree for 10 months time, big deal.  :-)  For
those who are need it, it allows them to participate without having to
do the heavy lifting of getting Virtex support into arch/powerpc.  It
also allow device driver development to progress on those boards in
the mean time.

Besides there is almost no new code in these changes.  The largest
part of the patch is a copy of older code (which I NAKed).  The other
changes are no big deal.

That being said, those excuses are *no* *bloody* *good* for folks like
me who *should* be getting virtex support into arch/powerpc.  :-)

Also, the moment it is viable to add new Virtex board ports to
arch/powerpc I will change my tune and agree 100% with you.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
