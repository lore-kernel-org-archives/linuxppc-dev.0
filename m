Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C4A6B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 02:52:03 +1100 (EST)
Received: from mail9-va3 (localhost.localdomain [127.0.0.1])	by
	mail9-va3-R.bigfish.com (Postfix) with ESMTP id 020C711F00AB	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 15:51:58 +0000 (UTC)
Received: from VA3EHSMHS017.bigfish.com (unknown [10.7.14.249])	by
	mail9-va3.bigfish.com (Postfix) with ESMTP id D6087FA004E	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2010 15:51:57 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9BFq8Gu008058	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 08:52:08 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9BFpuMq025660	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:51:56 -0500 (CDT)
Date: Mon, 11 Oct 2010 10:51:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
Message-ID: <20101011105155.1b2f4611@udp111988uds.am.freescale.net>
In-Reply-To: <4CB2DE2B.7040504@windriver.com>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<4CB2DE2B.7040504@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Mon, 11 Oct 2010 17:51:39 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> Maybe you can check the file, ppc4xx_pci.c since ppc4xx also can support EP as I
> previously said. And sounds Scott will do something to support EP for Freescale
> chip.

What did I get signed up for? :-)

-Scott
