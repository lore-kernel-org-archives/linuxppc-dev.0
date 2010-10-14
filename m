Return-Path: <david.hagood@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 9ED40B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 04:21:01 +1100 (EST)
Received: by yws5 with SMTP id 5so2756064yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 10:20:58 -0700 (PDT)
Message-ID: <fac55e564d1f5b7e5398354939ec3b43.squirrel@localhost>
In-Reply-To: <20101014113230.051b967a@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>
	<4CB2DEFB.90204@windriver.com>
	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>
	<942ea2f3464025464521511c32355782.squirrel@localhost>
	<20101012162152.5246744a@udp111988uds.am.freescale.net>
	<4CB5088D.4090201@windriver.com>
	<20101013102815.2959fcb6@udp111988uds.am.freescale.net>
	<4CB65F6F.1090103@windriver.com> <4CB6788D.60705@windriver.com>
	<20101014105126.08da9dd7@udp111988uds.am.freescale.net>
	<dccb3790f1fbb04a8df74bd920e57580.squirrel@localhost>
	<20101014113230.051b967a@udp111988uds.am.freescale.net>
Date: Thu, 14 Oct 2010 12:20:55 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: "tiejun.chen" <tiejun.chen@windriver.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallelujah and Huzzah! I finally got my vector!

I back-ported the MPIC_BROKEN_FRR_NIRQS flag and code to our kernel, and
the kernel is now letting me have my vector! Now I can actually see if the
dang thing works!

THANK YOU EVERYBODY for putting up with me on this!

> It comes from FRR[NIRQ].  It seems that this chip takes a
> less-than-useful interpretation of what that field means -- it gives
> the actual number of sources, not the size of the sparsely populated
> array.
Perhaps you might want to have a talk with your cow-orkers there, Scott,
since this is a Freescale part.

> It's not very clear to me what distinction the MPIC code is
> trying to make between irq_count and num_sources in the first place,
> though.
/me looks at Scott's email again.

If you, working FOR Freescale, and following the Linux development
(presumably for some time) are confused, imagine what I've been going
through!

Hot damn, and time for a quick version control commit, a hot lunch, and
really testing the code.

Thanks again!
