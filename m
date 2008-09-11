Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 1AA07DDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 14:36:04 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc4xx: Allow 4xx PCI bridge to be disabled via device
	tree
Date: Thu, 11 Sep 2008 06:30:56 +0200
References: <200809101755.46883.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200809101755.46883.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809110630.56392.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 September 2008, Matthias Fuchs wrote:
> This patch allows the 4xx (conventional) PCI bridge to be disabled
> via the device tree. This is needed for 4xx PCI adapter hardware.
>
> Use the PCI node's status property to disable the PCI bridge.
>
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
