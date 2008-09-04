Return-Path: <gunnar@genesi-usa.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 2576FDE1B1
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:14:12 +1000 (EST)
Received: by gxk14 with SMTP id 14so6342711gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:14:11 -0700 (PDT)
Message-ID: <b989d750809040814q2594c054i7dece706c49668f1@mail.gmail.com>
Date: Thu, 4 Sep 2008 17:14:11 +0200
From: "Gunnar Von Boehn" <gunnar@genesi-usa.com>
To: munroesj@us.ibm.com
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <1220538673.28869.261.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041405.16489.david.jander@protonic.nl>
	<20080904121926.GA12867@yoda.jdub.homelinux.org>
	<200809041459.27606.david.jander@protonic.nl>
	<1220538673.28869.261.camel@spokane1.rchland.ibm.com>
Cc: David Jander <david.jander@protonic.nl>, John Rigby <jrigby@freescale.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Steve,

> I have personally optimized memcpy for power4/5/6 and they are all
> different. There are dozens of different PPC implementations from
> different manufacturers and design, every one is different! With painful
> negotiation I was able to get the --with-cpu= framework added to glibc
> but not all distro use it. You can thank me later

Steve, you make it sound like very many different PowerPC chips:

You said you did the Power 4, Power 5 , Power 6 and now Power 7 routines.
And there are the 970 and the Cell.

While this sounds like 7 different PPC chips.
But aren't this actually only 2 main families?


Wouldn't it be possible to create two main routine to cover all?
One type that performs good on the family of Power4/5 and 7.
And one that performs good on the family of P6 and Cell?

How are the Linux hackers handling this?
Maybe there is room for consolidating?


Cheers
Gunnar
