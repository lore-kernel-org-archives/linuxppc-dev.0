Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id E7D4B2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 16:30:36 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 22 Oct 2004 08:30:31 +0200
References: <C18BA5DDB58DD511BD0700C0DF0DD4502941EC@NTSERVER4>
In-Reply-To: <C18BA5DDB58DD511BD0700C0DF0DD4502941EC@NTSERVER4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200410220830.31518.g.jaeger@sysgo.com>
Cc: Daren Hayward <darenh@4bridgeworks.com>
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

On Friday 22 October 2004 07:57, Daren Hayward wrote:
> What revision of the CPU do you have?? I know that upto rev C half duplex
> has a problem with the cpu and only REV C silicon works if I am not
> mistaken, there is an errata on IBM's website about this
>
> Daren
>
> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]
> Sent: 22 October 2004 03:02
> To: Hiroshi DOYU
> Cc: Linux PPC Embedded
> Subject: Re: [BUG] IBM440GX works too slow under nfsroot
>
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

Daren,
 
you are right about that, but this seems to be not true, even the latest REV C
seems to have problems - that's what we can observe here :(

Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
