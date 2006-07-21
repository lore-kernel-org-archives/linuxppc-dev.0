Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FDA0679FB
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Jul 2006 04:08:33 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Linas Vepstas'" <linas@austin.ibm.com>
Subject: RE: AltiVec in the kernel
Date: Fri, 21 Jul 2006 13:08:17 -0500
Message-ID: <002b01c6acf0$a7417050$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20060721165130.GS5905@austin.ibm.com>
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> Sounds like a problem of advertising and communications.  
> This is kind of "under the radar" for most users and 
> developers. It needs to work out-of-the-box, most people, 
> even those with interest in performance, will not even be 
> aware of the possibility to tne this.

It's listed on every site we have, and on PenguinPPC.org too if I
recall (hi Hollis) it even got a sticky news item like a lot of the
stuff we do (thanks Hollis :).

Everyone who cares knows about it, I would think. Probably not
enough people care, is the problem.

> It should be folded into glibc. It is up to the altivec 
> product vendor to nag the glibc folks into folding it in. 

You mean Freescale? Or Genesi?

Freevec was being developed as a "perfect opportunity". glibc-ports
came to life and was something that code could be contributed to.
Since it was such a hassle dealing with the glibc guys, it ended up
being a seperate library for now.

> This task could be as hard as writing the code in the first place.

I think we could handle it if there were less stubborn mules maintaining
the most important software. I can think of one guy in particular.. but
I won't name him.

> Many maintainers of core libraries have similar behaviour patterns.
> Besides glibc, gcc and gsl come to mind. This is becase they 
> get tired out by naive eager-beavers who walk in with the 
> greatest idea in the world

I think this kind of behaviour stalls Open Source software,
because it unfairly treats those *with* clues.

<-us-> do you want the AltiVec code or not?
<them> Oh no because I am bored of dealing with people who only had ideas!!

It doesn't make much sense politically or technically.

So like I said we could have had this code in glibc when glibc-ports
first was conceptualised and then released, but there was just too
many mules in the way.

Check the freevec.org whitepapers section), Konstantinos is not just
"ideas", he proved out optimizations and then implemented them.

Is it his fault that they're not in glibc, because he's "stupid" or
"clueless"? :D

> If you've got good code, you'll just need to be persistent.

Personally I am pretty tired (in return) with angry-faced Open
Source developers deciding that "Open Source" is equivalent to
"My Source, Back Off, Your Patch Sucks". It is always the choice
of the lead developer (and/or copyright holder) to refuse
patches, but.. seriously.. a lot of Open Source development is
the wrong kind of dictatorship.

Cynicism aside.. :D

</rant>

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
