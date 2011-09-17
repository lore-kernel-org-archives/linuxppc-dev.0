Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 522C7B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Sep 2011 20:13:36 +1000 (EST)
Message-ID: <4E7470E6.2000404@neli.hopto.org>
Date: Sat, 17 Sep 2011 12:05:26 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] RapidIO: documentation update
References: <1316092759-5460-1-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1316092759-5460-1-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Liu Gang <Gang.Liu@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
>  After the host has completed enumeration of the entire network it releases
>  devices by clearing device ID locks (calls rio_clear_locks()). For each endpoint
> -in the system, it sets the Master Enable bit in the Port General Control CSR
> +in the system, it sets the Discovered bit in the Port General Control CSR
>  to indicate that enumeration is completed and agents are allowed to execute
>  passive discovery of the network.

The host needs to set both. Without Master Enable an agent is not
supposed to initiate transactions on the "bus", that's the meaning of
that bit.

Micha
