Return-Path: <david.hagood@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 7FC8C1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 05:44:23 +1100 (EST)
Received: by iwn4 with SMTP id 4so295199iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 11:44:21 -0700 (PDT)
Message-ID: <b7e849f04892d41d865b6b38a92cc322.squirrel@localhost>
In-Reply-To: <20101014125010.5cfb4ee5@udp111988uds.am.freescale.net>
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
	<fac55e564d1f5b7e5398354939ec3b43.squirrel@localhost>
	<20101014125010.5cfb4ee5@udp111988uds.am.freescale.net>
Date: Thu, 14 Oct 2010 13:44:14 -0500
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


> Well, it was a coworker who added the workaround, so I assume we're
> already aware of the issue.
>
> The description of NIRQ is vague enough that it's hard to argue that
> Linux's expectations of what it means are justified.
>
Well, I now can actually interrupt the PPC from my host processor!

(well, it segfaulted, but's my fault for not actually initializing my work
queue structure. But I can get the interrupt into the part!)

So thanks to all.

I hope to get my code working, get past my delivery deadline on it, clean
it up so it matches The One True Way Of Laying Out Kernel Code, and post
it here for everybody to point and laugh at. Maybe around Christmas.
