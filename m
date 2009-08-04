Return-Path: <joakim.tjernlund@transmode.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5DDBFB7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Aug 2009 23:49:28 +1000 (EST)
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E21F7DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2009 23:49:25 +1000 (EST)
In-Reply-To: <20090714220931.GA11378@oksana.dev.rtsoft.ru>
References: <20090713222005.GA19859@oksana.dev.rtsoft.ru>
	<20090713151911.GA28114@oksana.dev.rtsoft.ru>
	<OFF188389D.68E638A2-ONC12575F2.00568C5B-C12575F2.0057FC95@transmode.se>
	<20090713173455.GA9866@oksana.dev.rtsoft.ru>
	<OF9378E65D.FBBCCFD5-ONC12575F2.006B28D5-C12575F2.006DDAE5@transmode.se>
	<OF613F53BF.1FD77EDB-ONC12575F3.00753535-C12575F3.00753537@transmode.se>
	<20090714220931.GA11378@oksana.dev.rtsoft.ru>
Subject: Re: Ang: Re: [PATCH 0/2] Setting GPIOs simultaneously
To: avorontsov@ru.mvista.com
Message-ID: <OF9A2BDEDE.DC0DE0D4-ONC1257608.004A7A59-C1257608.004AF3BF@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 4 Aug 2009 15:38:40 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 15/07/2009 00:09:31:
>
> On Tue, Jul 14, 2009 at 11:20:13PM +0200, Joakim Tjernlund wrote:
> [...]
> > >But any users of the legacy bindings should be in-tree.
> >
> > ehh, it was working until you made it OF only. Why do call the native
> > way legacy?  It is the method all non OF arch uses.
>
> It's legacy because there are no in-tree users anymore. Nowadays
> we're trying to pass all needed information via OF, and we're
> trying to avoid ugly platform-dependant hacks. Your SPI scheme
> can be easily described via OF, but sure, it's hard to implement
> it with the current SPI/OF subsystem.

Sorry for the long delay, I have been on vaction and been busy with other stuff.

Tell me, how does this new OF SPI device scheme work out if you want
to use the bitbanged SPI driver?

>
> [...]
> > >http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg34738.html
> > >^^^ I'm dreaming about this framework. I.e. true addressing
> > >    for chip-selects. :-)
> >
> > This is probably needed to support most SPI users out there, but until
> > such framework is in place I think the native methods need to stay, right?
>
> I'm not the right person to ask. I can only express my opinions.
> The maintainer make final decision.
>
> But if you ask for my opinion, I don't think that they should stay
> unless we'll see a user in the mainline.
>
> > As is now, SPI has regressed w.r.t earlier releases.
>
> Yes and no. Yes, it has "regressed" for out-of-tree code, and no,
> I don't feel sorry about that. :-)

That is a Yes and some bla bla so the answer is yes.

   Jocke
