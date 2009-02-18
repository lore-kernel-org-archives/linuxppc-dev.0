Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B5FADDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 17:03:57 +1100 (EST)
Subject: Re: setup_64.c:450: warning: format '%lx' expects type 'long
	unsigned int'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0902171418050.8852@vixen.sonytel.be>
References: <alpine.LRH.2.00.0902171418050.8852@vixen.sonytel.be>
Content-Type: text/plain
Date: Wed, 18 Feb 2009 17:03:50 +1100
Message-Id: <1234937030.14060.442.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-17 at 14:21 +0100, Geert Uytterhoeven wrote:
> and ASM_CONST() appends "UL" to the constant.
> 
We probably want to add a ASM_ULL_CONST() for that...

Ben.
