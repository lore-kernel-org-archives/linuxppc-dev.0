Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 081CF68540
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 18:29:17 +1100 (EST)
Subject: Re: [PATCH 11/16] PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
In-Reply-To: <200611210719.kAL7JsGH025487@toshiba.co.jp>
References: <200611160939.kAG9dqre027595@toshiba.co.jp>
	<1163676724.5940.378.camel@localhost.localdomain>
	<200611210719.kAL7JsGH025487@toshiba.co.jp>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 18:29:47 +1100
Message-Id: <1164094188.5597.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We read your IO workaroud patch for spider. The method for disabling prefetch
> is same as we suppose. And the method for dummy read may be available, 
> or be a good reference for us.
> We found a mistake in our patch at disabling prefetch. We set the prefetch
> enable bit wrongly.  We'll correct it in the next patch.

Excellent, thanks !

Ben.
