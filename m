Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 363ED2BF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 15:36:51 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so264520wra
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Jan 2005 20:36:50 -0800 (PST)
Message-ID: <855e88d005010420367a92617a@mail.gmail.com>
Date: Tue, 4 Jan 2005 23:36:49 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Ulrich Teichert <krypton@ulrich-teichert.org>
In-Reply-To: <855e88d005010407396309a9f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <855e88d005010405417d49dcfb@mail.gmail.com>
	<200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
	<855e88d005010407396309a9f9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Jan 2005 10:39:41 -0500, Mike Martin <sydneymartin@gmail.com> wrote:
> On Tue, 4 Jan 2005 16:23:50 +0100 (MET), Ulrich Teichert
> > Could you try to format them before dd'ing on them, like fdformat /dev/fd0h1440?
> > I am not sure if that will change anything, though.
> 
> Will do.

Done - no difference. Same message. Written multiple images, multiple
times on multiple machine. Each one with the same result. At least I'm
not completely alone, I found this:
http://wikihip.cern.ch/twiki/bin/view/RS6000/KernelTestsOn43P240 exact
same error.
 
> >
> > I am begining to believe that there is some sort of hardware problem with your
> > box or it is an upgraded version which was a -140 in it's previous life, but my
> > -140 is rock solid with Leigh's 2.4.19 kernel - once it's up, that is.
> > I will leave it running tonight to see what happens,
> >
> > HTH,
> > Uli
> 
> I am starting to believe this as well. I'm going to see if I can get
> some history on the machine from before it was shelved. As well, I
> know there is a second machine, I'm going to see if I can swap this
> one for that one and see if the same issues exist.
> 
> MikeMartin
> 
The machine was working fine under AIX when it was decomissioned. It
had some issues with a disk going bad due to heat (blocked vents). But
once they were cleared there were no issues. I am going to try the
other machine. I'll keep my finger's crossed.

MikeMartin
