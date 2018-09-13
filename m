Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429nl71VdczF2X0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 15:48:51 +1000 (AEST)
Message-ID: <4bfd06d41f21f6e3a57ce20e3ce155f6545a1ac3.camel@neuling.org>
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Tyrel Datwyler
 <tyreld@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 13 Sep 2018 15:48:50 +1000
In-Reply-To: <7d32de2e-b390-527d-cd5c-2c5eacc19a2c@c-s.fr>
References: <20180912052058.10062-1-mikey@neuling.org>
 <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
 <29d3467a9314f5b80f93d241ae2566c48b546bfe.camel@neuling.org>
 <e8a68da4-1c58-b30b-ccd0-f37a9e7c330c@linux.vnet.ibm.com>
 <7d32de2e-b390-527d-cd5c-2c5eacc19a2c@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-09-13 at 07:38 +0200, Christophe LEROY wrote:
>=20
> Le 13/09/2018 =C3=A0 03:21, Tyrel Datwyler a =C3=A9crit :
> > On 09/12/2018 05:36 PM, Michael Neuling wrote:
> > >=20
> > > >=20
> > > > > +			(unsigned long)patch_addr);
> > > >=20
> > > > Please align second line as per Codying style.
> > >=20
> > > Sorry I can't see what's wrong. You're (or Cody :-P) going to have to
> > > spell it
> > > this out for me...
> >=20
> > I suspect that the suggestion is the opening parenthesis of "(unsigned
> > long)" should sit directly under the "K" of "KERN_DEBUG". I'm pretty su=
re
> > Documentation/process/coding-style.rst is very adamant that all identat=
ion
> > is always 8 characters and spaces should never be used, but there still
> > seems to be a lot of places/suggestions that argument lists that spill =
over
> > multiple lines should be space indented to align with the very first
> > argument at the top level. So, I guess I'm not sure what the desire is =
here.
> > Although moving to pr_debug might fit it to a single line anyways. ;)
>=20
> It is exactly that, as reported by checkpatch, look at=20
> https://patchwork.ozlabs.org/patch/968850/

Sweet... looks like v3 is clean

https://patchwork.ozlabs.org/patch/969241/

Mikey
