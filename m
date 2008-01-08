Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B24B7DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:15:06 +1100 (EST)
Message-Id: <1315E111-6C49-4FB4-A4AA-806812A7CCFF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1199745618755-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] sbc85xx: remove PCI exclude device for sbc8548/sbc8560
Date: Tue, 8 Jan 2008 00:15:00 -0600
References: <E22DFF32-E85B-4A58-89D4-E447BEB8BA28@kernel.crashing.org>
	<1199745618755-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2008, at 4:40 PM, Paul Gortmaker wrote:

> The PCI exclude device for the sbc85xx boards was only filtering out
> the PHB and nothing else.  This functionality is no longer required
> at a board specific level -- it is handled as a more global quirk now.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Can you respin the full patch set with the update .dts to v1.

- k
