Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 986EEDDDD4
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 18:42:01 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Canyonlands PCIE Interrupt Handler
Date: Mon, 17 Nov 2008 08:41:55 +0100
References: <cbaa36330811141033y305285f9r97489ad5f85dd002@mail.gmail.com>
In-Reply-To: <cbaa36330811141033y305285f9r97489ad5f85dd002@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811170841.56188.sr@denx.de>
Cc: Deepak Pandian <peerlessdeepaks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 14 November 2008, Deepak Pandian wrote:
> I am trying to implement a platform driver for msi.  Whenever I write
> in to the PCIE-IH space, the kernel stops abruptly and the system is
> reset.

I have a PPC4xx MSI driver in my queue which still needs some polishing. 
Hopefully I'll find the time and post it this week.

Best regards,
Stefan
