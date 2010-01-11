Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1182AB7C14
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 09:53:54 +1100 (EST)
Subject: Re: PCI-PCI bridge scanning broken on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B4BAAC0.4010300@embedded-sol.com>
References: <4B388D9D.7010404@embedded-sol.com>
	<1262584539.2173.335.camel@pasglop>	<4B41ADF1.1000400@embedded-sol.com>
	<4B49CE8A.7000609@embedded-sol.com>	<1263155906.724.2.camel@pasglop>
	<4B4A4307.5050704@embedded-sol.com>	<1263159117.724.15.camel@pasglop>
	<4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
	<4B4B1027.4020708@embedded-sol.com> <4B4B55CF.9000707@embedded-sol.com>
	<1263243199.724.146.camel@pasglop> <4B4BAAC0.4010300@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 09:53:34 +1100
Message-ID: <1263250414.724.161.camel@pasglop>
Mime-Version: 1.0
Cc: Stef van Os <stef.van.os@Prodrive.nl>, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-01-12 at 00:48 +0200, Felix Radensky wrote:
> 
> Maybe because the bus behind root P2P bridge is bus 0, and type 1
> cycles are
> needed for bus numbers greater than 0. That's what 460EX manual says.

Well, no... the bus behind the root P2P is bus 1 ... the root P2P itself
is on bus 0... but then, it's some trick in the way they implemented it
I suppose.

> You are correct, the log is from older version, without Stef's fix. I 
> don't have access to a
> system with devices behind PLX, and the guy who did the testing used 
> wrong kernel.
> I'll make sure he uses the correct one and get back to you. Maybe 
> everything works after all :)
> I'm really sorry for confusion.

No worries :-) Feel free to send a proper patch to fix that problem
upstream too !

Cheers,
Ben.
