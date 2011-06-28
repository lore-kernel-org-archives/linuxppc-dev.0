Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 875B6B6F65
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 02:30:44 +1000 (EST)
Date: Tue, 28 Jun 2011 11:30:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mike Hench <mhench@elutions.com>
Subject: Re: [PATCH 2/2] mtd/nand : workaround for Freescale FCM to
	supportlarge-page Nand chip
Message-ID: <20110628113033.5e71a8ed@schlenkerla.am.freescale.net>
In-Reply-To: <F87D23B7E1F84E4AB52E4FA4A55F85DC0262C53D@tpamail.elutions.com>
References: <1309225852-1664-2-git-send-email-b35362@freescale.com>
	<F87D23B7E1F84E4AB52E4FA4A55F85DC0262C53D@tpamail.elutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: dwmw2@infradead.org, b35362@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2011 11:35:12 -0400
Mike Hench <mhench@elutions.com> wrote:

> 
> Any boot ideas ?
> Will the FCM load 2k and run it?

The 4K boot region will have to be split over pages 0 and 2 (2k view) or
the first half of pages 0 and 1 (4k view).

-Scott
