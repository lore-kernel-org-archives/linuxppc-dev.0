Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7912EDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 22:25:09 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 20 Jan 2009 12:25:06 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <3a68e478a75.2662f91@smtp.lizzy.com.au>
Message-ID: <20090120112506.278840@gmx.net>
MIME-Version: 1.0
References: <3a68e478a75.2662f91@smtp.lizzy.com.au>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 19 Jan 2009 19:28:35 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> The following patchset fixes core IDE PCI code to always use
> pci_get_legacy_ide_irq() and ide_pci_is_in_compatibility_mode():
> 
> http://lkml.org/lkml/2009/1/19/163
> 
> so via82cxxx specific solution is no longer necessary.
> 
> [ IOW I'll keep your previous patch and the #ifdef issue will
>   solve itself after the above patchset is merged. ]
Thanks a lot! That's much better than the simple fix I had planned.

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
