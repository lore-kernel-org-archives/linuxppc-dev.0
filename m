Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 0C3DF2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 16:26:56 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 22 Oct 2004 08:26:40 +0200
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<20041022103859.50e2b2f6.Hiroshi_DOYU@montavista.co.jp>
	<20041022020226.GC22069@gate.ebshome.net>
In-Reply-To: <20041022020226.GC22069@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410220826.40794.g.jaeger@sysgo.com>
Cc: 
Subject: Re: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 22 October 2004 04:02, Eugene Surovegin wrote:
> On Fri, Oct 22, 2004 at 10:38:59AM +0900, Hiroshi DOYU wrote:
> > On Thu, 21 Oct 2004 18:33:20 -0700
> >
> > Eugene Surovegin <ebs@ebshome.net> wrote:
> > > On Fri, Oct 22, 2004 at 08:57:33AM +0900, Hiroshi DOYU wrote:
> > > > Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
> > > > I could succeed to boot it but, after nfs mounted, it's behavior
> > > > seems too slow. I guess, it looks like the system is running
> > > > half duplex.
> > >
> > > Yeah, driver thinks it's connected to 10Mb hub. How the board is
> > > actualy connected to the network?
> >
> > 10Mb hub.
>
> Wow, I really had to spend some time to find such ancient hw :). I'll
> try 2.4.27 with this hub during next couple of days (I'm a little busy
> right now) and let you know. I suspect nobody really tested EMAC driver
> in 10Mb HDX mode.
>
> You can also bug Matt Porter, maybe he'll help you sooner :).

Hi Eugene,

this problem has been discussed a while ago between my co-worker and
Matt-Porter - first on the list and later on in private. We also have this
problem on a custom board using the 440GX. It can be also seen on a Ebony
(440GP) as well and on our rather old Ocotea. Our kernel originally is based
on 2.4.26, but the EMAC driver has been backported from 2.6.9.
Fiddling around with some settings seems to help a bit, but in the end we see
excessive collisions. The reason is not clear yet. 
Matt could not confirm this behaviour 'til now.

Ciao,
  Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
