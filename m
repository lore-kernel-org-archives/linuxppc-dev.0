Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 200B5DE31A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:06:41 +1000 (EST)
Message-Id: <EBD54E68-3DB2-4382-9BEB-2E7E7FBEADE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1211531568-31402-4-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/4 V5] Enable MSI support for 85xxds board
Date: Fri, 23 May 2008 08:06:31 -0500
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-4-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 3:32 AM, Jason Jin wrote:

> This patch enabled MSI on 8544ds and 8572ds board.
> So far only one MSI interrupt can generate on 8544 board.

What is the issue on 8544?

> Signed-off-by: Jason Jin <Jason.jin@freescale.com>

applied.

- k
