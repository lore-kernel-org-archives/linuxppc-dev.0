Return-Path: <rick.mcbain@logicsense.com>
Received: from mail146.megamailservers.com (mail146.megamailservers.com
	[216.251.36.146])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E1692BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 05:28:05 +1100 (EST)
Received: from RicksPresario900 (S01060008029ed28e.vs.shawcable.net
	[24.82.3.111])
	by mail146.megamailservers.com (8.12.10/8.12.9) with ESMTP id
	iA9IRbjM010486
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 Nov 2004 13:27:56 -0500
From: "Rick McBain" <rick.mcbain@logicsense.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 9 Nov 2004 10:27:37 -0800
Message-ID: <000001c4c689$cdad4380$6f035218@RicksPresario900>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20041109010006.932572BF32@ozlabs.org>
Subject: 440EP and Linux and MontaVista
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I posted some somewhat disparaging remarks about the cost of MontaVista
440EP Linux, and the quality of a previous dist. we got from them. Time
to set the record a bit straighter, after talking to the nice folks
there, and with our Linux guy here.  I wouldn't want to leave my earlier
post as the final word...

1. The ARM port we got did work (I said it didn't...), but our Linux guy
thought it low quality.  In MontaVista's defence, however, this was a
long, long time ago (5? years). MontaVista (and the rest of us) have
evolved a lot since then - I'm sure their current ARM port works just
dandy.

2. 25K for a company planning to sell 100K or 1M units is a small price
to have a stable, well supported OS.  Our problem is that we don't have
those volumes to ammortize the cost over, and we are a cash starved
startup. And we chose a processor which is not well supported yet, and
really had a wrench thrown in the works when IBM sold it to AMCC,
because it probably stalled Linux on that processor for 6 - 12 months
(AMCC only just recently hired a director of software for there 4xx
embedded processor division, so I expect that all this will get
straightened out with funding Timesys, etc., but unfortunately too late
for us. We need Linux now.)

For us, it appears most cost effective to pay to port existing drivers
to the 440EP. We need better RT performance than vanilla 2.6, so we will
also port RTAI.  From this, we expect a stable OS with better than 2.6
performance, but we will have to support it ourselves. Although we are
still in discussion with Timesys, so we may work something out there
yet.

Anyways, the bottom line remains that the cost of entry into Linux the
440EP processor is much higher than other Motorola, Intel, AMD, etc.
processors. I knew we were in for bumps when IBM sold the division, but
the processor has some unique features and performance that we couldn't
live without. I'm hoping that a bit of kicking and screaming will bring
AMCC up to par with the other guys...

Rick

Ps. No, MontaVista didn't threaten to sue me ;) I just don't like
leaving remarks around that are attributed to me that probably need
further explanation in order not to mislead.

And this way lets me send more missiles in areas I'm not thrilled with,
because people will understand that I am not just somebody who likes to
flame needlessly.  It's all about making things better.

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org [mailto:linuxppc-embedded-
> bounces@ozlabs.org] On Behalf Of linuxppc-embedded-request@ozlabs.org
> Sent: November 8, 2004 5:00 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Linuxppc-embedded Digest, Vol 3, Issue 10
> 
> Send Linuxppc-embedded mailing list submissions to
> 	linuxppc-embedded@ozlabs.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> 	linuxppc-embedded-request@ozlabs.org
> 
> You can reach the person managing the list at
> 	linuxppc-embedded-owner@ozlabs.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
> 
> 
> Today's Topics:
> 
>    1. Re: [BUG] IBM440GX works too slow under nfsroot (Eugene
Surovegin)
>    2. How much easier makes owning a BDI2000 things? (Peter Asemann)
>    3. RE: How much easier makes owning a BDI2000 things?
>       (VanBaren, Gerald (AGRE))
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Sun, 7 Nov 2004 18:55:04 -0800
> From: Eugene Surovegin <ebs@ebshome.net>
> Subject: Re: [BUG] IBM440GX works too slow under nfsroot
> To: Gerhard Jaeger <g.jaeger@sysgo.com>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <20041108025504.GA4112@gate.ebshome.net>
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, Oct 25, 2004 at 08:47:00AM +0200, Gerhard Jaeger wrote:
> > > If there is an interest, I can make a patch against current 2.4 BK
> > > tree, but this will take some time (I'm a little swamped right
now).
> >
> > of course there's some interest, at least by me ;) Would be great if
> you'll
> > find some time for that.
> 
> Patch against current 2.4 BK is available at
http://kernel.ebshome.net.
> Quick tested on Ebony & Ocotea.
> 
> --
> Eugene
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Mon, 08 Nov 2004 15:33:40 +0100
> From: Peter Asemann <peter.asemann@web.de>
> Subject: How much easier makes owning a BDI2000 things?
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <418F83C4.5000109@web.de>
> Content-Type: text/plain; charset=us-ascii; format=flowed
> 
> The tutorials in the web I read about getting custom hardware running
> suggest that having some BDI-thing like an Abatron BDI2000 is a really
> good idea.
> 
> Actually I need some arguments to have such a device bought. How much
> easier does it make things?
> 
> Peter Asemann
> 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Mon, 8 Nov 2004 07:44:05 -0700
> From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
> Subject: RE: How much easier makes owning a BDI2000 things?
> To: "Peter Asemann" <peter.asemann@web.de>,
> 	<linuxppc-embedded@ozlabs.org>
> Message-ID:
>
<065ACD8E84315E4394C835E398C8D5EB9E9DA2@COSSMGMBX02.email.corp.tld>
> Content-Type: text/plain;	charset="us-ascii"
> 
> 
> > -----Original Message-----
> > From: linuxppc-embedded-bounces@ozlabs.org
> > [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
> > Peter Asemann
> > Sent: Monday, November 08, 2004 9:34 AM
> > To: linuxppc-embedded@ozlabs.org
> > Subject: How much easier makes owning a BDI2000 things?
> >
> > The tutorials in the web I read about getting custom hardware
> > running suggest that having some BDI-thing like an Abatron
> > BDI2000 is a really good idea.
> >
> > Actually I need some arguments to have such a device bought.
> > How much easier does it make things?
> >
> > Peter Asemann
> 
> 42 times easier.
> 
> ******************************************
> The information contained in, or attached to, this e-mail, may contain
> confidential information and is intended solely for the use of the
> individual or entity to whom they are addressed and may be subject to
> legal privilege.  If you have received this e-mail in error you should
> notify the sender immediately by reply e-mail, delete the message from
> your system and notify your system manager.  Please do not copy it for
any
> purpose, or disclose its contents to any other person.  The views or
> opinions presented in this e-mail are solely those of the author and
do
> not necessarily represent those of the company.  The recipient should
> check this e-mail and any attachments for the presence of viruses.
The
> company accepts no liability for any damage caused, directly or
> indirectly, by any virus transmitted in this email.
> ******************************************
> 
> 
> ------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> End of Linuxppc-embedded Digest, Vol 3, Issue 10
> ************************************************
