Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51E16B6F8B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 06:55:21 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
Date: Wed, 28 Sep 2011 20:52:30 +0000
Message-ID: <CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
In-Reply-To: <20110927182912.GA3994@ponder.secretlab.ca>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 27, 2011 at 1:29 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

> The solution is to make the gpio driver register as a regular
> interrupt handler, and not as a chained handler.

I was wondering about that.

What exactly is a chained handler?  How is it different from a regular hand=
ler?

--=20
Timur Tabi
Linux kernel developer at Freescale=
