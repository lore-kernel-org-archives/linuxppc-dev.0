Return-Path: <hollis@penguinppc.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by ozlabs.org (Postfix) with ESMTP id 61AB867BDE
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 07:30:55 +1000 (EST)
Message-Id: <1153517448.21392.266596853@webmail.messagingengine.com>
From: "Hollis Blanchard" <hollis@penguinppc.org>
To: "Linas Vepstas" <linas@austin.ibm.com>, "Matt Sealey" <matt@genesi-usa.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <lezmf4j5ym.wl%bdc@carlstrom.com>
	<000001c6acd3$ea93f5c0$99dfdfdf@bakuhatsu.net>
	<20060721165130.GS5905@austin.ibm.com>
Subject: Re: AltiVec in the kernel
In-Reply-To: <20060721165130.GS5905@austin.ibm.com>
Date: Fri, 21 Jul 2006 16:30:48 -0500
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>,
	Konstantinos Margaritis <markos@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 21 Jul 2006 11:51:30 -0500, "Linas Vepstas"
<linas@austin.ibm.com> said:
> On Fri, Jul 21, 2006 at 09:42:32AM -0500, Matt Sealey wrote:
> > http://www.freevec.org/ 
> > 
> > Been there for months, before the glibc thing. Most of the functions
> > are ready. Anyone can bugfix this. The beauty of GPL. The ugly part
> > is.. we've had this there for months. Nobody has contributed a single
> > update or bugfix or even a performance test as far as I know.
> 
> Sounds like a problem of advertising and communications.  This is
> kind of "under the radar" for most users and developers. It needs to
> work out-of-the-box, most people, even those with interest in
> performance, will not even be aware of the possibility to tne this.

It is difficult to make sure every OSS developer is notified of all work
they may be interested in...

However, I have noticed a trend where Genesi people seem to think
everybody pays attention to their websites (and the same could be said
for Debian and other subcultures). In this case there actually have been
other people aware of this project, but not very many. Considering all
the traffic about it on ppczone.org, people looking for exposure for
their project may want to look beyond PPCZone.

> It should be folded into glibc. It is up to the altivec product vendor
> to nag the glibc folks into folding it in. This task could be as hard
> as writing the code in the first place.

Konstantinos is aware of Steve's glibc project and has indicated he'll
try to contribute to it.

To be fair, probably not many people have heard of Steve's project
either. I doubt Konstantinos would have heard of it if I hadn't
mentioned it.

-Hollis
