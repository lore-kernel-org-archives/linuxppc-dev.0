Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8100DDF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 00:12:45 +1000 (EST)
Message-ID: <48567494.8020905@freescale.com>
Date: Mon, 16 Jun 2008 09:11:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
References: <397587.26957.qm@web83513.mail.sp1.yahoo.com>
In-Reply-To: <397587.26957.qm@web83513.mail.sp1.yahoo.com>
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
> So are you implying that the request_irq function should work without any other initialization
> function before it?

No, I'm saying that you'll get a more accurate assessment of why it 
fails if you see where it returns an error code.
