Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86C7067A8D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 10:03:19 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050127195730.07d3b4e9@jack.colino.net>
References: <1106012932.4533.46.camel@gaston>
	<20050127195730.07d3b4e9@jack.colino.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 10:01:43 +1100
Message-Id: <1106866903.6244.99.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] radeonfb: massive update of PM code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-27 at 19:57 +0100, Colin Leroy wrote:
> On 18 Jan 2005 at 12h01, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > +module_param(default_dynclk, int, -2);
> 
> Btw, I have been told that module_param()'s third parameters is an octal
> used for permissions (as 0644).

Ah ... oh well, I'll have to check that out with Rusty
Ben.
