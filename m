Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 86444DE0F3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 23:42:47 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Fri, 6 Jun 2008 15:42:38 +0200
References: <48480987.1070701@freescale.com>
	<20080605225637.GG30980@yookeroo.seuss>
	<48493713.2070806@freescale.com>
In-Reply-To: <48493713.2070806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806061542.38908.sr@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 06 June 2008, Timur Tabi wrote:
> David Gibson wrote:
> > Aliases aren't trivially reversible, but it shouldn't be too hard to
> > write a helper function which will do the scan and parse you describe.
>
> How about I submit a patch adding a function called
> "of_get_aliased_index()"?

Would be very welcome. :)

Best regards,
Stefan
