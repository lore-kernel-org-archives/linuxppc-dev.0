Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 336FDB7D67
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 19:17:29 +1000 (EST)
Subject: Re: halt the system without any broadcast message on the console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bosi Daniele <Daniele.Bosi@mta.it>
In-Reply-To: <531B6536C9F737458807DF75064873C8BE62B40C49@mta-digimail.MTA.INT>
References: <531B6536C9F737458807DF75064873C8BE62B40C49@mta-digimail.MTA.INT>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 19:17:21 +1000
Message-ID: <1275297441.1931.593.camel@pasglop>
Mime-Version: 1.0
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-05-27 at 17:39 +0200, Bosi Daniele wrote:
> 
> I'd like to avoid this message on the console I'm using because at
> production time this has to be a simple serial port for external
> peripheral connection. (to do this on the command line we'll leave
> empty the "console" field).

I'm not sure I understand.

If the serial port has to talk to an external periph, then you don't
want the console on it, in which case it will not have the broadcast
messages. If it's a console, then it will get them ... along with
everything else a console gets.

Cheers,
Ben.
