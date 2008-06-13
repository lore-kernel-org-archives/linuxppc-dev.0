Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFE41DDF6B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 09:54:26 +1000 (EST)
Message-ID: <485308AA.9050802@freescale.com>
Date: Fri, 13 Jun 2008 18:54:18 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
References: <470944.9117.qm@web83514.mail.sp1.yahoo.com>
In-Reply-To: <470944.9117.qm@web83514.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> I don't know why request_irq is succeeding when the fsldma and dmaengine drivers are installed. 
> I'm using the same dts in both cases.

At this point, my only suggestion is to debug the request_irq() call and 
see what exactly fails.
