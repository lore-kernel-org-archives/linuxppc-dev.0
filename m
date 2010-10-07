Return-Path: <david.hagood@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 5DE50B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 08:01:20 +1100 (EST)
Received: by gwaa12 with SMTP id a12so131922gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Oct 2010 14:01:17 -0700 (PDT)
Message-ID: <ebf7779dead257c9e4fedbbf5f9a1459.squirrel@localhost>
In-Reply-To: <20101007152626.4e834d43@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
Date: Thu, 7 Oct 2010 16:01:13 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Thu, 7 Oct 2010 15:12:26 -0500.
>
> BTW, the MSIs are already described in an msi node in the device tree.
As far as I can tell, ONLY in root complex mode, not in endpoint mode,
which is what I am working with.

What I want is a means by which the system root complex can generate one
or more interrupts INTO the 8641 when it is operating in endpoint mode.
