Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id E7F102BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 19:39:17 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Fri, 22 Oct 2004 11:39:14 +0200
References: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
	<200410220826.40794.g.jaeger@sysgo.com>
	<20041022082955.GA27169@gate.ebshome.net>
In-Reply-To: <20041022082955.GA27169@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410221139.14098.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
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

On Friday 22 October 2004 10:29, Eugene Surovegin wrote:
> On Fri, Oct 22, 2004 at 08:26:40AM +0200, Gerhard Jaeger wrote:
> > this problem has been discussed a while ago between my co-worker and
> > Matt-Porter - first on the list and later on in private. We also have
> > this problem on a custom board using the 440GX. It can be also seen on a
> > Ebony (440GP) as well and on our rather old Ocotea. Our kernel originally
> > is based on 2.4.26, but the EMAC driver has been backported from 2.6.9.
> > Fiddling around with some settings seems to help a bit, but in the end we
> > see excessive collisions. The reason is not clear yet.
> > Matt could not confirm this behaviour 'til now.
>
> Hmm, did you see problems on 100 HDX as well, or only on 10 HDX?

I need to retest again, AFAIR. It was limited to the 10HDX.

>
> FWIW, I haven't seen any problems when testing my new EMAC driver with
> 100Mb hub, maybe it's only 10Mb related.
>
> Anyway, this is first time I'm hearing about half duplex problems,
> Matt just mentioned them on IRC to me.
>
> I'll try to do some tests this weekend, although I have to admit half
> duplex doesn't seem very important these days, nevertheless, if this
> can be fixed, we better do this :).

Fully ACK ;)
In general you are right, 10HDX should not be that important, but
nevertheless, there are enough installations and setups, where it
is still needed. 
The strangest thing which can be observed is, that even when you have
a point-to-point connection and you force the connection to 10HDX you'll
see a lot of collisions. As I mentioned, with our settings (should be
the same as you'll find in current 2.6.9), it could happen, that there
are almost no collisions in the beginning, but from time to time you'll
get some collision firework, which stops after a few seconds...

Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
