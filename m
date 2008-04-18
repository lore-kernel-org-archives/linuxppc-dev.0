Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 30D85DE7B8
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 00:26:57 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: Add NOR flash entry to Canyonlands DTS.
Date: Fri, 18 Apr 2008 16:26:09 +0200
References: <20080417193744.GA17524@ru.mvista.com>
In-Reply-To: <20080417193744.GA17524@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804181626.09585.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 April 2008, Valentine Barshak wrote:
> This patch adds NOR flash entry to the PowerPC 460EX Canyonlands DTS.

Right, I forgot to add this. But the partition names and sizes are a little 
different from those we used before (e.g. kilauea). I'll send a patch to 
update the Canyonlands & Glacier dts files in a short while.

Thanks.

Best regards,
Stefan
