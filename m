Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 1973F67B63
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 13:20:54 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1644292ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Aug 2006 20:20:52 -0700 (PDT)
Message-ID: <528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
Date: Tue, 1 Aug 2006 21:20:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Josh Boyer" <jwboyer@jdub.homelinux.org>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <1154481150.2676.3.camel@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/1/06, Josh Boyer <jwboyer@jdub.homelinux.org> wrote:
> On Tue, 2006-08-01 at 17:35 -0700, Mark A. Greer wrote:
> > On Tue, Aug 01, 2006 at 04:01:33PM -0500, Matthew McClintock wrote:
> > > On Tue, 2006-08-01 at 23:00 +0200, Guennadi Liakhovetski wrote:
> > > >
> > > > Mark A. Greer in his patch to port sandpoint to arch/powerpc put
> > > > sandpoint.dts under arch/powerpc/boot/dts/sandpoint.dts
> > >
> > > I believe in his latest patches he removed this part. The device trees
> > > were not included at all and he left this point open for discussion.
> >
> > That's correct.
> >
> > TBH, I think its wrong to keep them in the kernel source at all--yes,
> > the same argument could be made for arch/powerpc/boot but that's been
> > settled.
>
> Sorry, I have to disagree.  We're talking about device tree _source_
> files here.  I believe they should be included in the kernel source.
> Where that is, I don't have a particularly strong argument but they
> should be included.

I have to second that opinion.  The device tree is absolutely integral
with the rest of the code/drivers needed to support a board.  I say
there are stronger arguments for keeping the dts files in the kernel
source than there are for the boot wrapper.

powerpc/boot/dts makes a lot of sense to me.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
