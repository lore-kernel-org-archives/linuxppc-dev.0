Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93F77DE97B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:04:30 +1000 (EST)
Message-ID: <4807AD48.1040100@freescale.com>
Date: Thu, 17 Apr 2008 15:04:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<4807AB7A.90005@freescale.com> <4807AC15.4010008@freescale.com>
In-Reply-To: <4807AC15.4010008@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> No.  clrsetbits operates on I/O registers, not RAM.

Does lwarx require the EA to be cached memory or something?  The reservation is
held within the processor, so it should work on I/O.

-- 
Timur Tabi
Linux kernel developer at Freescale
