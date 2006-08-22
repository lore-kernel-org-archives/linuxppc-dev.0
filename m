Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA19D67BF2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 08:17:33 +1000 (EST)
Subject: Re: [PATCH 2/2] uninorth: Add module param 'aperture' for aperture
	size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1156236954.16513.141.camel@thor.lorrainebruecke.local>
References: <115608447678-git-send-email->  <11560844762890-git-send-email->
	<1156176559.16513.78.camel@thor.lorrainebruecke.local>
	<1156231536.21752.100.camel@localhost.localdomain>
	<1156236954.16513.141.camel@thor.lorrainebruecke.local>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 08:17:13 +1000
Message-Id: <1156285033.21752.107.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > It's basically expected that we set it ourselves and a module option 
> > doesn't seem like a terribly good idea to me...
> 
> Well, wasn't it you who suggested this? :)

Possibly, I don't always have good ideas :) I would rather have that
size be configured by the client driver... oh well, let's workaround
that for now by using a better default _and_ the module option.

> > Maybe we should just have the driver default to something more sensible
> > in addition to what AGPSize comes from userland ? like 64M ?
> 
> Might be a good idea.
> 
> 
