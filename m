Message-Id: <5.1.0.14.2.20030825183409.00abbd20@mail.ebshome.net>
Date: Mon, 25 Aug 2003 18:37:08 -0700
To: Ming Lei <mlei@Brocade.COM>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: more info on kernel BUG at page_alloc.c:225
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <7D17958F8536B640885BE12A446D548FCB2643@hq-ex-4.corp.brocad
 e.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 06:30 PM 8/25/2003, Ming Lei wrote:
> > At 05:15 PM 8/22/2003, ming lei wrote:
> > >I should have said my version of linux2.4.19 is
> > >ppc440GP port, so the line number is line 220 in
> > >original linux 2.4.19 from kernel.org website. Be
> > >clear
> >
> > Hmm, it's still not clear what version you are using.
> > kernel.org 2.4.19 doesn't have 440GP support.
> > Are you using devel_2_4 or linuxppc-2.4 BK trees or MVL ?
>
>it's linuxppc-2.4.19 bk tree.

Hmm, URL ?

> > Another question, do you run your test on IBM reference
> > platform (Ebony) or
> > on your custom hw ?
>
>custom board for both 440 and 405.

Try your test on Ebony.
440GP uses DDR RAM which is very tricky to implement/layout correctly. It
looks like you have hardware problems.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
