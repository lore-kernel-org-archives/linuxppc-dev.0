Return-Path: <jjboor@aimsys.nl>
Received: from smtp04.wanadoo.nl (smtp04.wanadoo.nl [194.134.35.144])
	by ozlabs.org (Postfix) with ESMTP id 3A9A867B39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 22:50:30 +1000 (EST)
In-Reply-To: <4283335A.7070209@intracom.gr>
References: <427F4D41.10908@intracom.gr>
	<883b9affce23db0859a4619cff66da4e@aimsys.nl>
	<4283335A.7070209@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8676a43d3458437f005cfa177a45a4a7@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 12 May 2005 14:50:26 +0200
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ah, very good, thanks

Jaap-Jan

On 12-mei-05, at 12:43, Pantelis Antoniou wrote:

> Jaap-Jan
>
> All mii operations are done under a spinlock with interrupts disabled.
>
> Regards
>
> Pantelis
