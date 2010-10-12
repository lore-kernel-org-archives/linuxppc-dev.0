Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E0AA5B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 12:37:50 +1100 (EST)
Message-ID: <4CB3BC66.9050402@windriver.com>
Date: Tue, 12 Oct 2010 09:39:50 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>	<4CB2DE2B.7040504@windriver.com>
	<20101011105155.1b2f4611@udp111988uds.am.freescale.net>
In-Reply-To: <20101011105155.1b2f4611@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
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

Scott Wood wrote:
> On Mon, 11 Oct 2010 17:51:39 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> Maybe you can check the file, ppc4xx_pci.c since ppc4xx also can support EP as I
>> previously said. And sounds Scott will do something to support EP for Freescale
>> chip.
> 
> What did I get signed up for? :-)

As far as I recalled you ever comment you will support EP when you replied to
David in the previous email. If no I may misunderstand something so sorry for
this :)

Tiejun

> 
> -Scott
> 
> 
