Return-Path: <markos@debian.gr>
Received: from flurry4.flurrymail.com (unknown [69.59.176.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D62F67BD4
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 20:07:27 +1000 (EST)
Message-ID: <16081441.1153561129049.JavaMail.flurry@flurry4.flurrymail.com>
Date: Sat, 22 Jul 2006 02:38:13 -0700 (PDT)
From: Konstantinos Margaritis <markos@debian.gr>
To: Hollis Blanchard <hollis@penguinppc.org>,
	Linas Vepstas <linas@austin.ibm.com>, Matt Sealey <matt@genesi-usa.com>
Subject: Re:Re: AltiVec in the kernel
In-Reply-To: 11187
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

(Writing this on a wap mobile phone)

actually, i knew about steve's effort as i am subscribed to glibc-ports. the problem is i am doing my military service this whole period (right now i am a sentry guard at an oupost somewhere in rhodes :-). the good news is that in about a month or less i'll return close to my home and i intend to get back to work asap. but till then i'm stuck here.
 
konstantinos

_____________________________
I sent this message from my cell phone using flurry.
Click here to get your email and news on your cell phone for free: 
http://www.flurry.com

--- Original Message ---
Date: Fri Jul 21 14:30:56 PDT 2006
From: Hollis Blanchard <hollis@penguinppc.org>
To: Linas Vepstas <linas@austin.ibm.com>, Matt Sealey <matt@genesi-usa.com>
Subject: Re: AltiVec in the kernel
---


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
