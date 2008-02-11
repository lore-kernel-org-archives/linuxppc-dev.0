Return-Path: <SRS0=RTqQ=TA=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 2034ADDE48
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 17:34:21 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PPC440EP Interrupt Triggering and Level Settings
Date: Mon, 11 Feb 2008 07:33:56 +0100
References: <1202671442.3384.15.camel@galileo.recco.de>
In-Reply-To: <1202671442.3384.15.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802110733.57267.sr@denx.de>
Cc: Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 10 February 2008, Wolfgang Ocker wrote:
> From: Wolfgang Ocker <weo@reccoware.de>
>
> Corrected IRQ triggering and level settings according to latest revision
> of the 440EP User Manual (rev 1.24 nov 16, 2007).
>
> The incorrect settings might cause a failure of the network if both
> onchip ethernet ports are under heavy load.
>
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>

Thanks, looks good.

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
