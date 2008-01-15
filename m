Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6DCCDDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:19:36 +1100 (EST)
Date: Tue, 15 Jan 2008 12:19:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2] [POWERPC] 4xx: Add 405EXr to cputable
Message-ID: <20080115181924.GA3848@loki.buserror.net>
References: <1200380955-10217-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200380955-10217-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 08:09:15AM +0100, Stefan Roese wrote:
> This patch adds the 405EXr to the powerpc cuptable. Basically the 405EXr
> is a 405EX with only one EMAC and only one PCIe interface.

Sounds like they have the same core... why do they need separate cputable
entries?

-Scott
