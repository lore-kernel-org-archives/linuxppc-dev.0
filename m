Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 8DB96DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 15:18:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so645207anc
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Dec 2007 20:18:35 -0800 (PST)
Message-ID: <fa686aa40712022018n4801f589ma872f5332d2fd6c3@mail.gmail.com>
Date: Sun, 2 Dec 2007 21:18:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI,
	PCI-X and PCI-Express support among others
In-Reply-To: <20071130185304.2ea3aad3@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
	<51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
	<20071130152742.GB4196@lixom.net> <47503619.2010202@freescale.com>
	<20071130185304.2ea3aad3@zod.rchland.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/30/07, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Fri, 30 Nov 2007 10:11:05 -0600
> Jon Loeliger <jdl@freescale.com> wrote:
>
> > Olof Johansson wrote:
> >
> > > I normally do "quilt diff | checkpatch.pl -" when use quilt. You could
> > > similarly do "git diff HEAD | checkpatch.pl -". You'd always get the
> > > warning about missing signed-off-by though.
> >
> > So do a "git log -p | checkpatch.pl -" instead? :-)
>
> That sort of defeats the purpose of running checkpatch.pl _before_ you
> commit things...

stg show | checkpatch.pl -

:-p

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
