Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id AFC1BB70A8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:29:40 +1000 (EST)
Message-ID: <4C692F31.2020705@neli.hopto.org>
Date: Mon, 16 Aug 2010 14:29:37 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 7/9] RapidIO: Add handling for PW message from a lost
	device
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-8-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-8-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> Add check if PW message source device is accessible and change PW message
> handler to recover if PW message source device is not available anymore (power
> down or link disconnect).

I am not quite sure what the point is of this patch. What do you need to 
recover from?

> To avoid possible loss of notification, the PW message handler scans the route
> back from the source device to identify end of the broken link.

Do you mean if port-writes are dropped? Then they did not reach you in 
the first place. If a link in between is broken, the associated switch 
will 'complain' and send port-writes, no?

Micha
