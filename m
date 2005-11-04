Return-Path: <vivenzio@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fmmailgate04.web.de", Issuer "WEB.DE AG" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6F5EA68679
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2005 06:48:34 +1100 (EST)
Received: by fmmailgate04.web.de (8.12.10/8.12.10/webde Linux 0.7) with ESMTP
	id jA4JWHPH022935
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Nov 2005 20:32:17 +0100
Message-ID: <436BB734.5010409@web.de>
Date: Fri, 04 Nov 2005 20:32:04 +0100
From: Vivenzio Pagliari <vivenzio@web.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1130999620.4680.28.camel@gaston>	
	<60381eeb0511030103w551fad25h3d9d7fa258764d5e@mail.gmail.com>	
	<1131052876.4680.78.camel@gaston>	
	<60381eeb0511032313i426db0c8o7254009240f6988a@mail.gmail.com>
	<1131088730.4680.251.camel@gaston>
In-Reply-To: <1131088730.4680.251.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Sender: vivenzio@web.de
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	=?UTF-8?B?RWRkeSBQZXRyacWfb3I=?= <eddy.petrisor@gmail.com>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
> I would say your first mistake is to use PREEMPT :) There are various
> issues with PREEMPT on ppc32 that have not really been addressed so far,
> and the USB code has some "holes" that I wouldn't trust in a PREEMPT
> environment.
> 

What do you mean exactly? Should CONFIG_PREEMPT not be used?
And what about CONFIG_PREEMPT_VOLUNTARY?

Vivenzio
