Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id C9FA2DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 16:43:38 +1000 (EST)
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200809021512.10132.david.jander@protonic.nl>
References: <200808251131.02071.david.jander@protonic.nl>
	<200809010923.28616.david.jander@protonic.nl>
	<1220261775.5234.217.camel@gentoo-jocke.transmode.se>
	<200809021512.10132.david.jander@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2008 08:43:35 +0200
Message-Id: <1220424215.7762.47.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>,
	munroesj@us.ibm.com
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-02 at 15:12 +0200, David Jander wrote:
=EF=BB=BF> I have made some astonishing discoveries, and I'd like to post t=
he
> used source-code somewhere in the meantime, any suggestions? To this list=
?

Yes, mail it.
I got a mpc8323/8321 board I want to try.

> For the MPC5121e, 16-register strides seem to be most optimal, whereas fo=
r the=20
> MPC5200B, 4-register stides give best performance. Also, plain C memcpy()=
=20

Plain C, is that the uClibc one?
Did you try to tweak it?

 Jocke
