Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7250BDDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 02:19:22 +1100 (EST)
Date: Sun, 23 Dec 2007 09:26:13 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Add information on enabling sound on the MPC8641 HPCN
Message-ID: <20071223152613.GA4817@lixom.net>
References: <11983809443854-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11983809443854-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 09:35:44PM -0600, Timur Tabi wrote:
> Add a comment to the DTS file for the MPC8641 HPCN describing a wiring change
> needed to get sound working on this board.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> For a two-line comment, I thought the DTS would be the best place to put this
> information.

Sounds like a board rework document on your support site is the right
place for this. We normally don't document board reworks required in
the linux sources, do we?


-Olof
