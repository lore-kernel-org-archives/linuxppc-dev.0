Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67032B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 10:51:58 +1100 (EST)
Subject: Re: Linux on ppc440gp
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Gorelik, Jacob (335F)" <jacob.gorelik@jpl.nasa.gov>
In-Reply-To: <C8D1D750.272D%Jacob.Gorelik@jpl.nasa.gov>
References: <C8D1D750.272D%Jacob.Gorelik@jpl.nasa.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 10:51:44 +1100
Message-ID: <1286409104.2463.373.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-10-06 at 07:35 -0700, Gorelik, Jacob (335F) wrote:
> UIC0 (32 IRQ sources) at DCR 0xc0
> UIC1 (32 IRQ sources) at DCR 0xd0 

That looks bad. Your device-tree probably. Check the DCR bindings.

I'm on vacation right now, I don't have time to review it in details,
but ask me again next week if you don't find some help in the meantime.

Cheers,
Ben.
