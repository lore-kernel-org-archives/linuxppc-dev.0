Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D3242C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 12:48:57 +1000 (EST)
Message-ID: <1372646926.18612.140.camel@pasglop>
Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 01 Jul 2013 12:48:46 +1000
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259F916BF@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
 <1366155021.23030.24@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259F2581C@039-SN2MPN1-022.039d.mgd.msft.net>
 <1368421223.19924.16.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259F916BF@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-07-01 at 02:38 +0000, Wang Dongsheng-B40534 wrote:
> Hi Benjamin & Kumar & scott,
> 
> I am not sure who can apply these patches...
> 
> Scott already ACK these patches.
> 
> A few days ago Scott have a pull request, Scott can accept them? Or ?

I'm happy to pull from Scott. Do somebody other than me has access to an
old Mac (a G5 for example) to check they don't break anything there ?

Ben.

> [v3,1/4] powerpc/mpic: add irq_set_wake support
> http://patchwork.ozlabs.org/patch/234934/
> 
> [v3,2/4] powerpc/mpic: add global timer support
> http://patchwork.ozlabs.org/patch/234935/
> 
> [v3,3/4] powerpc/mpic: create mpic subsystem object
> http://patchwork.ozlabs.org/patch/234936
> 
> [v3,4/4] powerpc/fsl: add MPIC timer wakeup support
> http://patchwork.ozlabs.org/patch/234937/
> 
> Thanks.
> 
> -dongsheng
> 
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Sunday, June 09, 2013 4:20 PM
> > To: 'Benjamin Herrenschmidt'
> > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> > galak@kernel.crashing.org
> > Subject: RE: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
> > 
> > Hi ben,
> > 
> > Could you apply these patches? Thanks. :)
> > 
> > - dongsheng
> > 
> > > -----Original Message-----
> > > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > > Sent: Monday, May 13, 2013 1:00 PM
> > > To: Wang Dongsheng-B40534
> > > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> > > galak@kernel.crashing.org
> > > Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
> > >
> > > On Mon, 2013-05-13 at 04:25 +0000, Wang Dongsheng-B40534 wrote:
> > > > Hi Benjamin,
> > > >
> > > > Could you apply these patches?
> > >
> > > I'll have a look, I was assuming Kumar would take them but since not
> > > I'll queue them up.
> > >
> > > Cheers,
> > > Ben.
> > >
> > > > Scott already ACK.
> > > >
> > > > [v3,1/4] powerpc/mpic: add irq_set_wake support
> > > > http://patchwork.ozlabs.org/patch/234934/
> > > >
> > > > [v3,2/4] powerpc/mpic: add global timer support
> > > > http://patchwork.ozlabs.org/patch/234935/
> > > >
> > > > [v3,3/4] powerpc/mpic: create mpic subsystem object
> > > > http://patchwork.ozlabs.org/patch/234936/
> > > >
> > > > [v3,4/4] powerpc/fsl: add MPIC timer wakeup support
> > > > http://patchwork.ozlabs.org/patch/234937/
> > > >
> > > > Thanks.
> > > >
> > > > > -----Original Message-----
> > > > > From: Wang Dongsheng-B40534
> > > > > Sent: Friday, May 03, 2013 9:54 AM
> > > > > To: 'galak@kernel.crashing.org'
> > > > > Cc: 'linuxppc-dev@lists.ozlabs.org'; Wood Scott-B07421;
> > > > > 'benh@kernel.crashing.org'
> > > > > Subject: RE: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
> > > > >
> > > > > Hi Kumar,
> > > > >
> > > > > Could you apply these patches?
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Wang Dongsheng-B40534
> > > > > > Sent: Tuesday, April 23, 2013 6:10 PM
> > > > > > To: galak@kernel.crashing.org
> > > > > > Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
> > > > > > Subject: RE: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake
> > > > > > support
> > > > > >
> > > > > > Hi Kumar,
> > > > > >
> > > > > > Could you apply these patches?
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > [v3,1/4] powerpc/mpic: add irq_set_wake support
> > > > > > http://patchwork.ozlabs.org/patch/234934/
> > > > > >
> > > > > > [v3,2/4] powerpc/mpic: add global timer support
> > > > > > http://patchwork.ozlabs.org/patch/234935/
> > > > > >
> > > > > > [v3,3/4] powerpc/mpic: create mpic subsystem object
> > > > > > http://patchwork.ozlabs.org/patch/234936/
> > > > > >
> > > > > > [v3,4/4] powerpc/fsl: add MPIC timer wakeup support
> > > > > > http://patchwork.ozlabs.org/patch/234937/
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Wood Scott-B07421
> > > > > > > Sent: Wednesday, April 17, 2013 7:30 AM
> > > > > > > To: Wang Dongsheng-B40534
> > > > > > > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> > > > > > > galak@kernel.crashing.org
> > > > > > > Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake
> > > > > > > support
> > > > > > >
> > > > > > > ACK
> > > > > > >
> > > > > > > -Scott
> > > > > > >
> > > > > > > On 04/16/2013 05:58:52 AM, Wang Dongsheng-B40534 wrote:
> > > > > > > > Hi scott,
> > > > > > > >
> > > > > > > > Could you ACK these patches?
> > > > > > > >
> > > > > > > > [PATCH v3 2/4] powerpc/mpic: add global timer support [PATCH
> > > > > > > > v3 3/4]
> > > > > > > > powerpc/mpic: create mpic subsystem object [PATCH v3 4/4]
> > > > > > > > powerpc/fsl: add MPIC timer wakeup support
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > >
> > >
> 
