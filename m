Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C9EEDDF7C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:01:18 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Michel =?utf-8?q?D=C3=A4nzer?= <michel@tungstengraphics.com>
Subject: Re: Powerbook shuts down hard when hot, patch found
Date: Mon, 1 Oct 2007 22:58:18 +0200
References: <200709282332.52819.mb@bu3sch.de> <200709301216.55123.mb@bu3sch.de>
	<1191225602.28457.22.camel@thor.sulgenrain.local>
In-Reply-To: <1191225602.28457.22.camel@thor.sulgenrain.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710012258.18716.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 01 October 2007 10:00:02 Michel D=C3=A4nzer wrote:
>=20
> On Sun, 2007-09-30 at 12:16 +0200, Michael Buesch wrote:
> >=20
> > Ah, forgot to say.
> > It does not crash immediately when the register is written. It takes ab=
out two seconds
> > to crash. And when the machine is colder to begin with, it takes slight=
ly
> > longer to trigger. That _might_ support your overheating theory.
> >=20
> > Though, it does not trigger when it's up and running, no matter how hot=
 you drive it.
>=20
> Maybe the thermal control module prevents it from overheating. Have you
> tried unloading it or loading it ASAP on bootup to see if that makes any
> difference either way?

I'm not sure how that works. Can I unload the framebuffer module? I mean,
when I unloaded it, how does the console access the display?
Your suggestion might be less trivial to do than it sounds like. :)
I currently have compiled the stuff into the kernel image.

=2D-=20
Greetings Michael.
