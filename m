Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 5D538DDE08
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 18:30:10 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: munroesj@us.ibm.com
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Mon, 1 Sep 2008 10:29:22 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200808291348.27652.david.jander@protonic.nl>
	<1220042061.28869.184.camel@spokane1.rchland.ibm.com>
In-Reply-To: <1220042061.28869.184.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809011029.23413.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 August 2008 22:34:21 Steven Munroe wrote:
> > I am not complaining. I was only wondering if it is just me or there
> > really is very little that has been done (for either uClibc, glibc, or
> > whatever for powerpc) to improve performance of (linux-) applications on
> > "lower"-power platforms (G2 core), AFAICS there is a LOT that can be
> > gained by simple tweaks.
>
> This is a self help group (free as in freedom) We help each other. And
> you can help yourself. There is no free lunch.

I never expected to be served a free dish of any kind on a mailing-list ;-)
I was just asking around, to avoid reinventing wheels, since I intend to dig 
into this problem, that's all. My intention never was to pick up work from 
others and then run.

> > The problem is: I have very little experience with powerpc assembly and
> > only very limited time to dedicate to this and I am looking for others
> > who have
>
> Well this will be a good learning experience for you. We will try to
> answer questions.

Excellent. I love learning new stuff ;-)

Thanks a lot for the guidance so far...

Regards,

-- 
David Jander
